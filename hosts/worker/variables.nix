{
  timeZone = "Europe/Moscow";
  

  disk = "/dev/vda";

  network = {
    interface = "ens3";
    address = "PUBLIC_IPV4";
    prefixLength = 32;
    gateway = "GATEWAY_IPV4";
  };

  k3s.serverAddr = "SERVER_IPV4";

  vkTurnProxy = {
    enabled = false;

    connectAddr = "singbox-vk-turn.singbox.svc.cluster.local:4443";
    obfKey = "OBF_KEY";
  };

  vaultwarden = {
    enabled = false;
    domain = "DOMAIN_NAME";
  };

  singbox.enabled = false;
}
