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
      {
        name = "fish-bd";
        src = pkgs.fishPlugins.fish-bd.src;
      }
    ];

    interactiveShellInit = ''
      bass export LANG=en_US.UTF-8

      set fish_greeting

      set sponge_delay 5
      set sponge_successful_exit_codes 0 1 130 148
    '';
  };
}