{ lib, settings, ... }:
{
  networking.firewall.extraCommands = lib.concatMapStringsSep "\n" (address: ''
    iptables -A nixos-fw -s ${lib.escapeShellArg address} -p tcp -m multiport --dports 6443,10250 -j nixos-fw-accept
    iptables -A nixos-fw -s ${lib.escapeShellArg address} -p udp --dport 51820 -j nixos-fw-accept
  '') settings.k3s.workersAddr + ''
    iptables -A nixos-fw -i cni0 -s 10.42.0.0/16 -p tcp --dport 6443 -j nixos-fw-accept
    iptables -A nixos-fw -i flannel-wg -s 10.42.0.0/16 -p tcp --dport 6443 -j nixos-fw-accept
  '';

  services.k3s = {
    enable = true;
    role = "server";
    disable = [
      "local-storage"
      "metrics-server"
    ];
    extraFlags = [
      "--write-kubeconfig-mode=600"
      "--service-node-port-range=443-32767"
      "--flannel-backend=wireguard-native"
    ];
  };
}
