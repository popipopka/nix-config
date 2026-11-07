{ username, ...}:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
    flake = "/Users/${username}/nix-config";
  };

  home.shellAliases = {
    nhs = "nh darwin switch";
    nhca = "nh clean all";
  };
}