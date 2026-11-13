{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "popipopka";
  gitEmail = "eg.belykh@yandex.ru";

  # Server location timezone
  timeZone = "Europe/Berlin";

  # Primary disk used by disko and GRUB.
  disk = "/dev/vda";

  network = {
    interface = "ens3";
    address = "PUBLIC_IPV4";
    prefixLength = 32;
    gateway = "GATEWAY_IPV4";
  };

  singbox = {
    enabled = false;
    domain = "DOMAIN_NAME";

    bitwarden = {
      accessToken = "ACCESS_TOKEN";
      organizationId = "ORG_ID";
      usersSecretId = "SECRET_ID";
    };
  };
}
