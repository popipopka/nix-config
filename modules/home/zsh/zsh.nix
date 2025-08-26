{ profile, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" "pattern" "regexp" "root" "line" ];
    };

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
      ignorePatterns = ["kill *"];
    };


    oh-my-zsh = {
      enable = true;
    };

    shellAliases = {
      # nvim
      sv = "sudo nvim";
      v = "nvim";

      # Basic
      c = "clear";
    };

    initContent = ''
      if [ -f $HOME/.zshrc-personal ]; then
        source $HOME/.zshrc-personal
      fi
    '';

  };
}
