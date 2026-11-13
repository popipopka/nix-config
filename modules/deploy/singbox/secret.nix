{ settings, ... }:
[
{
  apiVersion = "v1";
  kind = "Secret";
  metadata = {
    name = "bitwarden-sm-auth";
    namespace = "singbox";
  };
  type = "Opaque";
  stringData.token = settings.singbox.bitwarden.accessToken;
}

{
  apiVersion = "k8s.bitwarden.com/v1";
  kind = "BitwardenSecret";
  metadata = {
    name = "singbox-users";
    namespace = "singbox";
  };
  spec = {
    organizationId = settings.singbox.bitwarden.organizationId;
    secretName = "singbox-users";
    authToken = {
      secretName = "bitwarden-sm-auth";
      secretKey = "token";
    };
    map = [
      {
        bwSecretId = settings.singbox.bitwarden.usersSecretId;
        secretKeyName = "users.json";
      }
    ];
  };
}
]
