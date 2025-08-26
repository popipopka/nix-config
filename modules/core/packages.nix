{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  programs = {
      neovim = {
        enable = true;
        defaultEditor = true;
      };

      hyprland = {
        enable = true; #set this so desktop file is created
        withUWSM = false;
      };

      dconf.enable = true;
#      seahorse.enable = true;
      fuse.userAllowOther = true;

      adb.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

  environment.systemPackages = with pkgs; [
    inputs.hyprsysteminfo.packages.${pkgs.system}.default
#    home-manager

    # Рабочее окружение
    greetd.tuigreet
    file-roller
    mpv

    # Разработка
    git
    docker-compose

    # Диагностика системы
    lm_sensors
    pciutils
    usbutils
    lshw
    glxinfo
    inxi
  ];

  environment.shells = with pkgs; [
    zsh
    bash
  ];
}
