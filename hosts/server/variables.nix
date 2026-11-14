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

    bitwarden = {
      accessToken = "ACCESS_TOKEN";
      organizationId = "ORG_ID";
      usersSecretId = "SECRET_ID";
    };
  };

  vkTurnProxy.enabled = false;
}
