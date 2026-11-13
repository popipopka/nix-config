{ settings, ... }:
[
  {
    apiVersion = "cert-manager.io/v1";
    kind = "Issuer";
    metadata = {
      name = "letsencrypt";
      namespace = "singbox";
    };
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory";
        privateKeySecretRef = {
          name = "letsencrypt-account";
        };
        solvers = [
          {
            http01 = {
              ingress = {
                ingressClassName = "traefik";
              };
            };
          }
        ];
      };
    };
  }
  
  {
    apiVersion = "cert-manager.io/v1";
    kind = "Certificate";
    metadata = {
      name = "singbox-tls";
      namespace = "singbox";
    };
    spec = {
      secretName = "singbox-tls";
      dnsNames = [
        settings.singbox.domain
      ];
      issuerRef = {
        name = "letsencrypt";
        kind = "Issuer";
      };
    };
  }
]
