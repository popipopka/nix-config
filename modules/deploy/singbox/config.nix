{ settings, ... }:
{
  apiVersion = "v1";
  kind = "ConfigMap";
  metadata = {
    name = "singbox";
    namespace = "singbox";
  };
  data = {
    "config.json" = builtins.toJSON {
      log = {
        level = "info";
        timestamp = true;
      };
      inbounds = [
        {
          type = "hysteria2";
          tag = "hy2-in";
          listen = "::";
          listen_port = 443;
          tls = {
            enabled = true;
            server_name = settings.singbox.domain;
            certificate_path = "/etc/sing-box/tls/tls.crt";
            key_path = "/etc/sing-box/tls/tls.key";
          };
          masquerade = "https://azbyka.ru/";
        }
        {
          type = "naive";
          tag = "naive-in";
          listen = "::";
          listen_port = 1443;
          network = "tcp";
          tls = {
            enabled = true;
            server_name = settings.singbox.domain;
            certificate_path = "/etc/sing-box/tls/tls.crt";
            key_path = "/etc/sing-box/tls/tls.key";
          };
        }
        {
          type = "anytls";
          tag = "anytls-in";
          listen = "::";
          listen_port = 2443;
          tls = {
            enabled = true;
            server_name = settings.singbox.domain;
            certificate_path = "/etc/sing-box/tls/tls.crt";
            key_path = "/etc/sing-box/tls/tls.key";
          };
        }
        {
          type = "tuic";
          tag = "tuic-in";
          listen = "::";
          listen_port = 3443;
          congestion_control = "cubic";
          zero_rtt_handshake = false;
          tls = {
            enabled = true;
            server_name = settings.singbox.domain;
            certificate_path = "/etc/sing-box/tls/tls.crt";
            key_path = "/etc/sing-box/tls/tls.key";
            alpn = [
              "h3"
            ];
          };
        }
      ];
      outbounds = [
        {
          type = "direct";
          tag = "direct";
        }
        {
          type = "block";
          tag = "block";
        }
      ];
      route = {
        final = "direct";
      };
      experimental = {
        clash_api = {
          external_controller = "127.0.0.1:9090";
        };
      };
    };
  };
}
