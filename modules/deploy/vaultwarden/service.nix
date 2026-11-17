{ ... }:
{
  apiVersion = "v1";
  kind = "Service";
  metadata = {
    name = "vaultwarden";
    namespace = "vaultwarden";
  };
  spec = {
    type = "ClusterIP";
    selector.app = "vaultwarden";
    ports = [
      {
        port = 80;
        targetPort = 80;
        protocol = "TCP";
      }
    ];
  };
}
