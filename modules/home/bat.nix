{ pkgs, lib, ...}: {
  programs.bat = {
    enable = true;

    config = {
      pager = "less -FR";
      style = "full";
      theme = lib.mkForce "GitHub";
    };

    extraPackages = with pkgs.bat-extras; [
      prettybat
    ];
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };

  home.shellAliases = {
    cat = "bat";
  };
}

