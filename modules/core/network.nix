{ pkgs, host, options, ... }:
{
  networking = {
    hostName = host;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [
      ];
    };
  };
}
