{ ... }:
{
  apiVersion = "v1";
  kind = "Service";
  metadata = {
    name = "vk-turn-proxy";
    namespace = "vk-turn-proxy";
  };
  spec = {
    type = "NodePort";
    selector.app = "vk-turn-proxy";
    ports = [
      {
        name = "vk-turn";
        protocol = "UDP";
        nodePort = 31000;
        port = 56000;
        targetPort = 56000;
      }
    ];
  };
}
