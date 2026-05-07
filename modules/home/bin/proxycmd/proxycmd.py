import base64
import json
import os
import signal
import socket
import subprocess
import sys
import tempfile
import threading
import time
import urllib.parse
import urllib.request
from pathlib import Path

KEYS_FILE = Path.home() / "proxycmd" / "keys.json"
HEALTH_URL = "https://www.gstatic.com/generate_204"
HEALTH_TIMEOUT = 2


def load_keys():
    try:
        with open(KEYS_FILE) as f:
            return json.load(f)
    except FileNotFoundError:
        return {}


def save_keys(keys):
    KEYS_FILE.parent.mkdir(parents=True, exist_ok=True)
    tmp = KEYS_FILE.with_suffix(".tmp")
    with open(tmp, "w") as f:
        json.dump(keys, f, indent=2)
    os.replace(tmp, KEYS_FILE)


def wait_for_port(port, timeout=10):
    start = time.time()
    while time.time() - start < timeout:
        try:
            with socket.create_connection(("127.0.0.1", port), timeout=0.5):
                return True
        except OSError:
            time.sleep(0.1)
    return False


def health_check(http_port, timeout=HEALTH_TIMEOUT):
    proxy = urllib.request.ProxyHandler({"https": f"http://127.0.0.1:{http_port}"})
    opener = urllib.request.build_opener(proxy)
    try:
        resp = opener.open(HEALTH_URL, timeout=timeout)
        return resp.status == 204
    except Exception:
        return False


def parse_ss(uri):
    uri = uri.split("#")[0]
    parsed = urllib.parse.urlparse(uri)
    userinfo = parsed.username
    try:
        decoded = base64.b64decode(userinfo + "=" * (-len(userinfo) % 4)).decode()
        method, password = decoded.split(":", 1)
    except Exception:
        method = parsed.username
        password = parsed.password
    return {
        "type": "shadowsocks",
        "server": parsed.hostname,
        "server_port": parsed.port,
        "method": method,
        "password": password,
    }


def parse_vless(uri):
    parsed = urllib.parse.urlparse(uri)
    params = dict(urllib.parse.parse_qsl(parsed.query))

    outbound = {
        "type": "vless",
        "server": parsed.hostname,
        "server_port": parsed.port,
        "uuid": parsed.username,
        "flow": params.get("flow", ""),
    }

    sni = params.get("sni", parsed.hostname)
    security = params.get("security", "none")
    if security == "tls":
        outbound["tls"] = {
            "enabled": True,
            "server_name": sni,
        }
    elif security == "reality":
        fp = params.get("fp", "") or "chrome"
        outbound["tls"] = {
            "enabled": True,
            "server_name": sni,
            "utls": {
                "enabled": True,
                "fingerprint": fp,
            },
            "reality": {
                "enabled": True,
                "public_key": params.get("pbk", ""),
                "short_id": params.get("sid", ""),
            },
        }

    transport = params.get("type", "tcp")
    if transport == "ws":
        outbound["transport"] = {
            "type": "ws",
            "path": params.get("path", "/"),
            "headers": {"Host": params.get("host", parsed.hostname)},
        }
    elif transport == "grpc":
        outbound["transport"] = {
            "type": "grpc",
            "service_name": params.get("serviceName", ""),
        }

    return outbound


PARSERS = {"vless://": parse_vless, "ss://": parse_ss}


def build_outbound(uri):
    parser = next((f for prefix, f in PARSERS.items() if uri.startswith(prefix)), None)
    if parser is None:
        raise ValueError(f"Unsupported protocol: {uri.split('://')[0]}")
    return parser(uri)


def free_port():
    with socket.socket() as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]


def start_proxy(uri):
    """Start sing-box for given URI. Returns (proc, http_port, config_path) or raises."""
    outbound = build_outbound(uri)
    http_port = free_port()

    config = {
        "log": {"disabled": True},
        "inbounds": [
            {"type": "http", "listen": "127.0.0.1", "listen_port": http_port},
        ],
        "outbounds": [outbound],
    }

    with tempfile.NamedTemporaryFile(mode="w", suffix=".json", delete=False) as f:
        json.dump(config, f)
        config_path = f.name

    try:
        proc = subprocess.Popen(
            ["sing-box", "run", "-c", config_path],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
    except Exception:
        os.unlink(config_path)
        raise
    return proc, http_port, config_path


def stop_proxy(proc, config_path):
    try:
        proc.send_signal(signal.SIGTERM)
        proc.wait(timeout=3)
    except subprocess.TimeoutExpired:
        proc.kill()
        proc.wait()
    except OSError:
        pass  # process already gone
    try:
        os.unlink(config_path)
    except Exception:
        pass


def make_proxy_env(http_port):
    env = os.environ.copy()
    env["ALL_PROXY"] = env["all_proxy"] = env["HTTPS_PROXY"] = env["HTTP_PROXY"] = (
        f"http://127.0.0.1:{http_port}"
    )
    return env


def run_with_proxy(uri, cmd):
    """Run cmd through a proxy for uri."""
    proc, http_port, config_path = start_proxy(uri)
    try:
        if not wait_for_port(http_port):
            print("Error: sing-box failed to start within 10 seconds", file=sys.stderr)
            sys.exit(1)

        result = subprocess.run(cmd, env=make_proxy_env(http_port))
        sys.exit(result.returncode)
    finally:
        stop_proxy(proc, config_path)


def auto_select(cmd):
    """Race all saved keys simultaneously, use the fastest responding one."""
    keys = load_keys()
    if not keys:
        print("Error: no keys saved. Use 'proxycmd add <name> <uri>'", file=sys.stderr)
        sys.exit(1)

    winner = threading.Event()
    winner_data = [None]  # (name, http_port, proc, config_path)
    lock = threading.Lock()
    all_procs = {}  # name -> (proc, config_path)

    def try_key(name, uri):
        try:
            proc, http_port, config_path = start_proxy(uri)
        except Exception as e:
            print(f"  [{name}] failed to start: {e}", file=sys.stderr)
            return

        with lock:
            all_procs[name] = (proc, config_path)

        if not wait_for_port(http_port, timeout=10):
            with lock:
                all_procs.pop(name, None)
            stop_proxy(proc, config_path)
            return

        if winner.is_set():
            return

        if health_check(http_port):
            with lock:
                if not winner.is_set():
                    winner.set()
                    winner_data[0] = (name, http_port, proc, config_path)

    for name, uri in keys.items():
        threading.Thread(target=try_key, args=(name, uri), daemon=True).start()

    try:
        winner.wait(timeout=HEALTH_TIMEOUT + 2)

        if winner_data[0] is None:
            print("Error: no keys responded in time", file=sys.stderr)
            sys.exit(1)

        chosen_name, chosen_port, chosen_proc, chosen_cfg = winner_data[0]

        print(f"Using key: {chosen_name}", file=sys.stderr)

        with lock:
            losers = [(p, c) for n, (p, c) in all_procs.items() if n != chosen_name]
        for proc, cfg in losers:
            stop_proxy(proc, cfg)

        result = subprocess.run(cmd, env=make_proxy_env(chosen_port))
        sys.exit(result.returncode)
    finally:
        with lock:
            snapshot = list(all_procs.values())
        for proc, cfg in snapshot:
            stop_proxy(proc, cfg)


def cmd_help(_args=None):
    print("""\
Usage: proxycmd <subcommand|key_name|uri|command> [args...]

Key management:
  proxycmd add <name> <uri>        save a connection key
  proxycmd remove <name>           remove a key
  proxycmd list                    list all saved keys

Running commands:
  proxycmd <key_name> <command>    run via named key
  proxycmd <uri> <command>         run via explicit vless:// or ss:// URI
  proxycmd <command>               auto-select fastest available key

Supported protocols:
  vless://   VLESS TLS, REALITY with TCP, WebSocket, gRPC
  ss://      Shadowsocks

Examples:
  proxycmd add fin 'vless://...'
  proxycmd fin curl https://example.com
  proxycmd curl https://example.com
  proxycmd list""")


def cmd_add(args):
    if len(args) != 2:
        print("Usage: proxycmd add <name> <uri>", file=sys.stderr)
        sys.exit(1)
    name, uri = args
    try:
        build_outbound(uri)  # validate
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
    keys = load_keys()
    keys[name] = uri
    save_keys(keys)
    print(f"Saved key '{name}'")


def cmd_remove(args):
    if len(args) != 1:
        print("Usage: proxycmd remove <name>", file=sys.stderr)
        sys.exit(1)
    name = args[0]
    keys = load_keys()
    if name not in keys:
        print(f"Error: key '{name}' not found", file=sys.stderr)
        sys.exit(1)
    del keys[name]
    save_keys(keys)
    print(f"Removed key '{name}'")


def cmd_list(_args):
    keys = load_keys()
    if not keys:
        print("No keys saved.")
        return
    for name, uri in keys.items():
        # hide uuid/password in output
        short = uri[:60] + "..." if len(uri) > 60 else uri
        print(f"  {name:20s} {short}")


def main():
    signal.signal(signal.SIGTERM, lambda *_: sys.exit(1))

    args = sys.argv[1:]

    if not args:
        cmd_help()
        sys.exit(0)

    subcommand = args[0]

    commands = {
        "help": lambda a: cmd_help(),
        "add": lambda a: cmd_add(a[1:]),
        "remove": lambda a: cmd_remove(a[1:]),
        "list": lambda a: cmd_list(a[1:]),
    }
    if subcommand in commands:
        commands[subcommand](args)
        return

    # explicit URI (old behaviour)
    if subcommand.startswith("vless://") or subcommand.startswith("ss://"):
        if len(args) < 2:
            print("Usage: proxycmd <uri> <command>", file=sys.stderr)
            sys.exit(1)
        run_with_proxy(subcommand, args[1:])
        return

    # named key
    keys = load_keys()
    if subcommand in keys:
        if len(args) < 2:
            print(f"Usage: proxycmd {subcommand} <command>", file=sys.stderr)
            sys.exit(1)
        run_with_proxy(keys[subcommand], args[1:])
        return

    # auto-select: all args are the command
    auto_select(args)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(130)
