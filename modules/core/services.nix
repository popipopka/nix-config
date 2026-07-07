{ ... }:
{
  # Сервисы
  services = {
    fstrim.enable = true; # Оптимизация SSD

    # Мониторинг состояния дисков через SMART
    smartd = {
      enable = true;
      autodetect = true;
    };

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
