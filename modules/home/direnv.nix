{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    silent = true;

    config = {
      global = {
        warn_timeout = "0";
        hide_env_diff = true;
      };
      whitelist = {
        prefix = [ "~/Projects" ];
      };
    };
  };
}

