_: {
  programs.eza = {
    enable = true;

    icons = "auto";
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--header" # Show header row
      "--git-ignore"
      "--icons=always"
      "--classify" # append indicator (/, *, =, @, |)
      "--hyperlink" # make paths clickable in some terminals
    ];
  };

  home.shellAliases = {
    ls = "eza";
    ll = "eza  -lh --no-user --long";
    lt = "eza --tree --level=2";
    la = "eza -lah";
    tree = "eza --tree";
  };
}

