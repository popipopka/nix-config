{ pkgs, ... }:
{
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = {
      add_newline = true;

      format = ''$directory$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$cmd_duration$line_break$character'';

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
