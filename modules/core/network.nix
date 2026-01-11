{ pkgs, host, options, ...}:

let
  inherit (import ../../hosts/${host}/variables.nix) hostId;
in
{
  networking = {
    hostName = "${host}";
    hostId = hostId;

    networkmanager = {
      enable = true;
    };

    nameservers = [
      "94.140.14.49"
      "94.140.14.59"
    ];

    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
      ];
      allowedUDPPorts = [
        59010
        59011
      ];
    };
  };
}

