{ lib, settings, ... }:
{
  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -s ${lib.escapeShellArg settings.k3s.serverAddr} -p tcp --dport 10250 -j nixos-fw-accept
    iptables -A nixos-fw -s ${lib.escapeShellArg settings.k3s.serverAddr} -p udp --dport 51820 -j nixos-fw-accept
  '';

  services.k3s = {
    enable = true;
    role = "agent";
    
    serverAddr = "https://${settings.k3s.serverAddr}:6443";
    tokenFile = "/root/nix-config/hosts/worker/k3s-token-file";
  };
}
