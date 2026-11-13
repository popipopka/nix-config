{ settings, ... }:
{
  services.k3s.manifests = {
    reloader.content = import ../charts/reloader.nix {};
    singbox-namespace.content = import ./namespace.nix {};
    singbox-service.content = import ./service.nix {};
    bitwarden-operator.content = import ../charts/bitwarden.nix {};
    singbox-deployment.content = import ./deployment.nix { inherit settings; };
    singbox-config.content = import ./config.nix { inherit settings; };
    singbox-secret.content = import ./secret.nix { inherit settings; };
    singbox-certificate.content = import ./certificate.nix { inherit settings; };
  };
}
