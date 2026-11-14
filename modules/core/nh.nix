{ pkgs, ...}:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };

    flake = "/root/nix-config";
  };

  environment.shellAliases = {
    nhs = "nh os switch --bypass-root-check";
    nhca = "nh clean all";
  };
}
