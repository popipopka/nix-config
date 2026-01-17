{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    fzf
    grc
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      sv = "sudo nvim";
      v = "nvim";
      c = "clear";
    };

    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];

    interactiveShellInit = ''
      set fish_greeting
      
      # Решение проблемы с цветовой схемой
      set -g fish_color_normal normal
      set -g fish_color_command green         # Команды
      set -g fish_color_keyword magenta       # Ключевые слова (if, end)
      set -g fish_color_quote yellow          # Кавычки
      set -g fish_color_redirection cyan      # > / <
      set -g fish_color_end yellow            # ; / &&
      set -g fish_color_error red             # Ошибки
      set -g fish_color_param blue 
      set -g fish_color_option cyan
      
      set -g fish_color_comment brwhite
      set -g fish_color_autosuggestion brwhite
      
      set -g fish_color_operator cyan
      set -g fish_color_escape cyan

      if test "$TERM" = "xterm-kitty"
        alias ssh="kitty +kitten ssh"
      end

      bind \e\[3\;5~ backward-kill-word       # Ctrl + Backspace
    '';
  };
}