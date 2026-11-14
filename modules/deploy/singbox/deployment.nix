{ settings, ... }:
[
  {
    apiVersion = "apps/v1";
    kind = "Deployment";
    metadata = {
      name = "singbox";
      namespace = "singbox";
      annotations = {
        "secret.reloader.stakater.com/reload" = "singbox-users,singbox-tls";
      };
      labels = {
        app = "singbox";
      };
    };
    spec = {
      replicas = 1;
      selector = {
        matchLabels = {
          app = "singbox";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "singbox";
          };
        };
        spec = {
          initContainers = [
            {
              name = "prepare-config";
              image = "badouralix/curl-jq";
              command = [ "/bin/sh" "-ec" ];
              args = [ ''
                umask 077
                jq --slurpfile users /secrets/users.json '
                  .inbounds |= map(
                    .tag as $tag
                    | $users[0][$tag] as $entries
                    | if ($entries | type) == "array" and ($entries | length) > 0
                      then .users = $entries
                      else error("Missing users for inbound: \($tag)")
                      end
                  )
                ' /base/config.json > /result/config.json
              '' ];
              volumeMounts = [
                { name = "config"; mountPath = "/base"; readOnly = true; }
                { name = "users"; mountPath = "/secrets"; readOnly = true; }
                { name = "ready-config"; mountPath = "/result"; }
              ];
            }
          ];
          containers = [
            {
              name = "singbox";
              image = "ghcr.io/sagernet/sing-box:v1.14.4";
              args = [
                "run"
                "-c"
                "/etc/sing-box/config.json"
              ];
              readinessProbe = {
                exec = {
                  command = [
                    "/bin/sh"
                    "-ec"
                    "wget -T 2 -q -O /dev/null http://127.0.0.1:9090/version"
                  ];
                };
                periodSeconds = 5;
                timeoutSeconds = 3;
              };
              volumeMounts = [
                {
                  name = "ready-config";
                  mountPath = "/etc/sing-box/config.json";
                  subPath = "config.json";
                  readOnly = true;
                }
                {
                  name = "tls";
                  mountPath = "/etc/sing-box/tls.crt";
                  subPath = "tls.crt";
                  readOnly = true;
                }
                {
                  name = "tls";
                  mountPath = "/etc/sing-box/tls.key";
                  subPath = "tls.key";
                  readOnly = true;
                }
              ];
            }
          ];
          volumes = [
            {
              name = "ready-config";
              emptyDir.medium = "Memory";
            }
            {
              name = "users";
              secret.secretName = "singbox-users";
            }
            {
              name = "config";
              configMap.name = "singbox";
            }
            {
              name = "tls";
              secret.secretName = "singbox-tls";
            }
          ];
        };
      };
    };
  }
]
