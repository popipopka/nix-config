{ lib, ... }:
{
  git-hooks.hooks = {
    nixfmt.enable = lib.mkDefault true;
    statix.enable = lib.mkDefault true;
    deadnix.enable = lib.mkDefault true;
  };
}
