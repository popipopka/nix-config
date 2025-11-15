{ pkgs, inputs, config, pkgsUnstable, lib, ... }: {
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

  environment.sessionVariables.LD_LIBRARY_PATH = lib.mkForce 
    "${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib pkgs.zlib pkgs.libGL pkgs.glib ]}:${toString (builtins.getEnv "LD_LIBRARY_PATH")}";

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
    google-chrome
    (pkgsUnstable.telegram-desktop)
    (pkgsUnstable.obsidian)
    (pkgsUnstable.affine)
    notepadqq
    (pkgsUnstable.yandex-music)
    baobab
    
    # Разработка
    python313
    python310
    mysql84
    gcc
    ngrok
    ninja
    nodejs_24
    go

    # Диагностика системы
    lm_sensors
    pciutils
    usbutils
    lshw
    ethtool
    glxinfo
    inxi
    lsof
    
    # Системные либы
    libnotify
    stdenv.cc.cc.lib
    zlib
    ffmpeg
    libGL
    glib
    
    # PDF
    poppler
    
    # Терминал
    doxx
    
    # Wake On LAN
    wakeonlan
  ];

  environment.shells = with pkgs; [
    zsh
    bash
  ];
}
