{
  timeZone = "Europe/Moscow";

  disk = "/dev/vda";

  network = {
    interface = "ens3";
    address = "PUBLIC_IPV4";
    prefixLength = 32;
    gateway = "GATEWAY_IPV4";
  };

  k3s.workersAddr = [
    "WORKER_IPV4"
  ];

  singbox = {
    enabled = false;
    domain = "DOMAIN_NAME";

    proxy.vkTurn = false;

    bitwarden = {
      accessToken = "ACCESS_TOKEN";
      organizationId = "ORG_ID";
      usersSecretId = "SECRET_ID";
    };
  };

  vaultwarden = {
    enabled = false;
    domain = "DOMAIN_NAME";
  };

  vkTurnProxy = {
    enabled = false;
    connectAddr = "singbox-vk-turn.singbox.svc.cluster.local:4443";
    obfKey = "OBF_KEY";
  };
}
