{}:
{
  progrms.fish = {
    enable = true;

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
    ];

    interactiveShellInit = ''
      set fish_greeting

      if test "$TERM" = "xterm-kitty"
        alias ssh="kitty +kitten ssh"
      end

      bind \b backward-kill-word
      bind \x7f backward-kill-word
      bind \e\[3\;5~ backward-kill-word
    '';
  };
}