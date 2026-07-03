{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  programs = {
      neovim = {
        enable = true;
        defaultEditor = true;
      };

      git.enable = true;
      fish.enable = true;
  };


  environment = {
    systemPackages = with pkgs; [
      # Базовые консольные утилиты
      bat
      btop
      curl
      dig
      eza
      fd
      fzf
      inetutils
      jq
      lsof
      ripgrep
      rsync
      wget
    ];

    shells = with pkgs; [
      fish
      bash
    ];
  };
}
