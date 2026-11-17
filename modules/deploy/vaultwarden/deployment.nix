{ settings, ... }:
{
  apiVersion = "apps/v1";
  kind = "Deployment";
  metadata = {
    name = "vaultwarden";
    namespace = "vaultwarden";
  };
  spec = {
    replicas = 1;
    strategy.type = "Recreate";
    selector.matchLabels.app = "vaultwarden";
    template = {
      metadata.labels.app = "vaultwarden";
      spec = {
        containers = [
          {
            name = "vaultwarden";
            image = "vaultwarden/server:latest";
            env = [
              {
                name = "DOMAIN";
                value = "https://${settings.vaultwarden.domain}";
              }
              {
                name = "SIGNUPS_ALLOWED";
                value = "false";
              }
              {
                name = "INVITATIONS_ALLOWED";
                value = "false";
              }
              {
                name = "SENDS_ALLOWED";
                value = "true";
              }
              {
                name = "ENABLE_WEBSOCKET";
                value = "true";
              }
              {
                name = "PUSH_ENABLED";
                value = "false";
              }
            ];
            volumeMounts = [
              {
                name = "data";
                mountPath = "/data";
              }
            ];
          }
        ];
        volumes = [
          {
            name = "data";
            persistentVolumeClaim.claimName = "vaultwarden-data";
          }
        ];
      };
    };
  };
}
