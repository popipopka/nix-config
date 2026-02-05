{ pkgs, ... }:
{
  programs.starship = {
    enable = true;

    enableFishIntegration = true;

    settings = {
      add_newline = true;

      format = ''$directory$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$cmd_duration$fill$java$kotlin$python$c$gradle$cmake$line_break$character'';

      fill = {
        symbol = " ";
      };

      java = {
        symbol = "  ";
        style = "red";
      };
      kotlin = {
        symbol = "  ";
        style = "blue";
      };
      python = {
        symbol = "  ";
        style = "yellow";
      };
      c = {
        symbol = "  ";
        style = "149";
        detect_extensions = ["c" "h" "cpp"];
      };

      gradle = {
        symbol = "  ";
        style = "bright-cyan";
      };
      cmake = {
        symbol = "󰔶  ";
        style = "blue";
      };

      username = {
        style_user = "bold cyan";
        show_always = true;
      };
      directory = {
        truncation_symbol = "…/";
        style = "bold blue";
        read_only = " 󰌾";
      };
      character = {
        success_symbol = "[➜](green)";
        error_symbol = "[✗](red)";
      };
    };
  };
}
