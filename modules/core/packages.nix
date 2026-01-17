{ pkgs, inputs, config, upkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowCollisions = true;
  
  nixpkgs.config.permittedInsecurePackages = [
    "electron-35.7.5"
    "qtwebengine-5.15.19"
  ];
  
  # Unstable канал
  _module.args.upkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  programs = {
      neovim = {
        enable = true;
        defaultEditor = true;
      };

      hyprland = {
        enable = true;
        withUWSM = false;
      };

      dconf.enable = true;
      fuse.userAllowOther = true;

      adb.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      amnezia-vpn = {
        enable = true;
      };
  };


  environment = {
    systemPackages = with pkgs; [
      # База
      file-roller
      nemo-with-extensions
      google-chrome
      notepadqq
      baobab
      (upkgs.bitwarden-desktop)
      (upkgs.telegram-desktop)

      # Разработка
      python313
      python312
      python310
      nodejs_24
      go
      flutter
      mysql84
      postgresql
      ngrok
      gcc
      ninja
      devenv

      # Диагностика системы
      lm_sensors
      pciutils
      usbutils
      lshw
      ethtool
      mesa-demos
      inxi
      lsof

      # Системные либы
      libnotify
      stdenv.cc.cc.lib
      #zlib
      ffmpeg
      #libGL
      #glib
      poppler
      grc

      # Файловая система
      exfatprogs  #exFAT
      parted
    ];

    shells = with pkgs; [
      zsh
      fish
      bash
    ];
  };
}
