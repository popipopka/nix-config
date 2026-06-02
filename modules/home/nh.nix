{ pkgs, username, ...}:
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
    nhds = "nh darwin switch";
    nhca = "nh clean all";
  };
}