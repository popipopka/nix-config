{ settings, ... }:
[
  {
    apiVersion = "apps/v1";
    kind = "Deployment";
    metadata = {
      name = "vk-turn-proxy";
      namespace = "vk-turn-proxy";
    };
    spec = {
      replicas = 1;
      selector.matchLabels.app = "vk-turn-proxy";
      template = {
        metadata.labels.app = "vk-turn-proxy";
        spec = {
          nodeSelector."kubernetes.io/hostname" = "worker";
          containers = [
            {
              name = "vk-turn-proxy";
              image = "ghcr.io/cacggghp/vk-turn-proxy:latest";
              env = [
                {
                  name = "CONNECT_ADDR";
                  value = settings.vkTurnProxy.connectAddr;
                }
              ];

            }
          ];
        };
      };
    };
  }
]
