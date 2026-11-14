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
  };
}
