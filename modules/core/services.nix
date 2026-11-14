{ ... }:
{
  # Сервисы
  services = {
    fstrim.enable = true; # Оптимизация SSD

    # BTRFS
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = false;
      };
      ports = [ 22 ];
      openFirewall = true;
    };
  };
}
