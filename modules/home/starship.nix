{ pkgs, ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;

      format = ''
        $directory\
        $git_branch\
        $git_commit\
        $git_state\
        $git_metrics\
        $git_status\
        $hg_branch\
        $cmd_duration\

        $fill\

        $java\
        $kotlin\
        $python\
        $c\

        $gradle\
        $cmake\

        $line_break\
        $character
      '';

      fill = {
        symbol = " ";
      };

      java = {
        format = "[${symbol}(${version})]($style) ";
        symbol = "  ";
        style = "red";
      };
      kotlin = {
        format = "[${symbol}(${version})]($style) ";
        symbol = "  ";
        style = "blue";
      };
      python = {
        format = "[${symbol}${pyenv_prefix}(${version})(\($virtualenv\))]($style) ";
        symbol = "  ";
        style = "yellow";
      };
      c = {
        format = "[${symbol}($version(-$name))]($style) ";
        symbol = "  ";
        style = "149";
        detect_extensions = ["c" "h" "cpp"];
      };

      gradle = {
        format = "via [${symbol}($version)]($style)";
        symbol = "  ";
        style = "bright-cyan";
      };
      cmake = {
        format = "via [${symbol}($version)]($style)";
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
