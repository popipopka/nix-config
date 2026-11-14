{ config, lib, settings, ... }:

{
  networking.firewall.allowedUDPPorts = [
    31000
  ];

  services.k3s.manifests = lib.mkIf (config.services.k3s.role == "server") {
    vk-turn-proxy-namespace.content = import ./namespace.nix {};
    vk-turn-proxy-service.content = import ./service.nix {};
    vk-turn-proxy-deployment.content = import ./deployment.nix { inherit settings; };
  };
}
