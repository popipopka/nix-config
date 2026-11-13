{ ... }:
{
  apiVersion = "v1";
  kind = "Service";
  metadata = {
    name = "singbox";
    namespace = "singbox";
  };
  spec = {
    type = "NodePort";
    selector.app = "singbox";
    ports = [
      {
        name = "hysteria2";
        protocol = "UDP";
        nodePort = 31000;
        port = 443;
        targetPort = 443;
      }
      {
        name = "naive";
        protocol = "TCP";
        nodePort = 31001;
        port = 1443;
        targetPort = 1443;
      }
      {
        name = "anytls";
        protocol = "TCP";
        nodePort = 31002;
        port = 2443;
        targetPort = 2443;
      }
      {
        name = "tuic";
        protocol = "UDP";
        nodePort = 31003;
        port = 3443;
        targetPort = 3443;
      }
    ];
  };
}
