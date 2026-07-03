{ pkgs, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [ "--all" ];
      };
    };

    podman.enable = false;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    docker-buildx
    dive

    kubectl
  ];

  services.k3s = {
    enable = true;
    role = "server";
    disable = [
      "traefik"
      "servicelb"
      "local-storage"
      "metrics-server"
    ];
    extraFlags = [
      "--write-kubeconfig-mode=600"
    ];
  };
}
