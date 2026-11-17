{ settings, ... }:
{
  services.k3s.manifests = {
    cert-manager.content = import ../charts/cert-manager.nix {};
    vaultwarden-namespace.content = import ./namespace.nix {};
    vaultwarden-deployment.content = import ./deployment.nix { inherit settings; };
    vaultwarden-service.content = import ./service.nix {};
    vaultwarden-storage.content = import ./storage.nix {};
    vaultwarden-ingress.content = import ./ingress.nix { inherit settings; };
    vaultwarden-certificate.content = import ./certificate.nix { inherit settings; };
  };
}
