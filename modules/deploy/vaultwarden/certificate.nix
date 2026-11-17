{ settings, ... }:
[
  {
    apiVersion = "cert-manager.io/v1";
    kind = "Issuer";
    metadata = {
      name = "letsencrypt";
      namespace = "vaultwarden";
    };
    spec.acme = {
      server = "https://acme-v02.api.letsencrypt.org/directory";
      privateKeySecretRef.name = "letsencrypt-account";
      solvers = [
        {
          http01.ingress.ingressClassName = "traefik";
        }
      ];
    };
  }
  {
    apiVersion = "cert-manager.io/v1";
    kind = "Certificate";
    metadata = {
      name = "vaultwarden-tls";
      namespace = "vaultwarden";
    };
    spec = {
      secretName = "vaultwarden-tls";
      dnsNames = [ settings.vaultwarden.domain ];
      issuerRef = {
        name = "letsencrypt";
        kind = "Issuer";
      };
    };
  }
]
