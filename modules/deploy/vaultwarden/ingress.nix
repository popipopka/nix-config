{ settings, ... }:
{
  apiVersion = "networking.k8s.io/v1";
  kind = "Ingress";
  metadata = {
    name = "vaultwarden";
    namespace = "vaultwarden";
  };
  spec = {
    ingressClassName = "traefik";
    rules = [
      {
        host = settings.vaultwarden.domain;
        http.paths = [
          {
            path = "/";
            pathType = "Prefix";
            backend.service = {
              name = "vaultwarden";
              port.number = 80;
            };
          }
        ];
      }
    ];
    tls = [
      {
        hosts = [ settings.vaultwarden.domain ];
        secretName = "vaultwarden-tls";
      }
    ];
  };
}
