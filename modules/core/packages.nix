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
    # JetBrains
    jetbrains.pycharm-professional

    # Офисный пакет
    libreoffice
    hunspell
    hunspellDicts.ru-ru
    hunspellDicts.en-us

    # Рабочее окружение
    file-roller
    nemo-with-extensions
    featherpad
    font-manager
    nekoray
    google-chrome
    telegram-desktop
    #mpv

    # Разработка
    git
    python313

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
