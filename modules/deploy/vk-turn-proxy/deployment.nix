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
          containers = [
            {
              name = "vk-turn-proxy";
              image = "ghcr.io/hackdiaz-dev/free-turn-proxy@sha256:0949d7d991313812ce6e1579f9f520ea30ec26cd7348e8701d16ef879bbd9f00";
              imagePullPolicy = "Always";
              env = [
                {
                  name = "CONNECT_ADDR";
                  value = settings.vkTurnProxy.connectAddr;
                }
                {
                  name = "LISTEN_ADDR";
                  value = "0.0.0.0:56000";
                }
                {
                  name = "MODE";
                  value = "udp";
                }
                {
                  name = "OBF_PROFILE";
                  value = "rtpopus3";
                }
                {
                  name = "OBF_KEY";
                  value = settings.vkTurnProxy.obfKey;
                }
              ];

            }
          ];
        };
      };
    };
  }
]
