{ pkgs, inputs, config, pkgsUnstable, ... }: {
  nixpkgs.config.allowUnfree = true;
  
  nixpkgs.config.permittedInsecurePackages = [
    "electron-35.7.5"
  ];
  
  # Unstable канал
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

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
    # Код
    (pkgsUnstable.jetbrains.pycharm-professional)
    (pkgsUnstable.jetbrains.idea-ultimate)
    (pkgsUnstable.android-studio)
    (pkgsUnstable.code-cursor)
    (pkgsUnstable.yaak)
    insomnia
    dbeaver-bin

    # Офисный пакет
    libreoffice
    hunspell
    hunspellDicts.ru-ru
    hunspellDicts.en-us

    # Рабочее окружение
    file-roller
    nemo-with-extensions
    font-manager
    nekoray
    google-chrome
    (pkgsUnstable.telegram-desktop)
    (pkgsUnstable.obsidian)
    (pkgsUnstable.affine)
    notepadqq
    (pkgsUnstable.yandex-music)
    
    # ВУЗ
    ciscoPacketTracer7
    ciscoPacketTracer8

    # Разработка
    python313
    python310
    mysql84
    gcc
    ngrok
    nodejs_24

    # Диагностика системы
    lm_sensors
    pciutils
    usbutils
    lshw
    glxinfo
    inxi
    lsof
    
    # Системные либы
    libnotify
    stdenv.cc.cc.lib
    zlib
    ffmpeg
    
    # PDF
    poppler
    
    # Терминал
    doxx
  ];

  environment.shells = with pkgs; [
    zsh
    bash
  ];
}
