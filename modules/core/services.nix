{ profile, ... }:
{
  # Сервисы
  services = {
    libinput.enable = true; # Драйвера для устройств ввода
    blueman.enable = true; # GUI для Bluetooth

    fstrim.enable = true; # Оптимизация SSD
    gvfs.enable = true; # Для монтирования USB & more

    tumbler.enable = true; # Миниатюры для файлов/видео
    gnome.gnome-keyring.enable = true; # Хранилище паролей и ключей

    # SSH
    #openssh = {
    #  enable = true; # Enable SSH
    #  settings = {
    #    PermitRootLogin = "no"; # Prevent root from SSH login
    #    PasswordAuthentication = true; #Users can SSH using kb and password
    #    KbdInteractiveAuthentication = true;
    #  };
    #  ports = [ 22 ];
    #};

    # Мониторинг состояния дисков через SMART
    smartd = {
      enable =
        if profile == "vm"
        then false
        else true;
      autodetect = true;
    };
    
    # BTRFS
    btrfs.autoScrub = {
      enable  = true;
      interval = "monthly";
    };

    # udisks. Нужен для udiskie
    udisks2 = {
      enable = true;
    };

    # Pipeware
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # Оптимизация для низкой задержки
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "256/48000";
              pulse.default.req = "256/48000";
              pulse.max.req = "256/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "256/48000";
            };
          }
        ];
      };
    };
  };
}
