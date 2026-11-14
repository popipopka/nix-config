{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) network;
in
{
  networking = {
    hostName = host;
    useDHCP = false;
    
    interfaces.${network.interface}.ipv4 = {
      addresses = [
        { 
          address = network.address; 
          prefixLength = network.prefixLength; 
        }
      ];
      routes = [
        {
          address = "0.0.0.0";
          prefixLength = 0;
          via = network.gateway;
          options = {
            onlink = "";
            src = network.address;
          };
        }
      ];
    };
    
    nameservers = [ "1.1.1.1" "9.9.9.9" ];

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
