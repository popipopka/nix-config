{ username, lib, ... }:
{
  system = {
    primaryUser = "${username}";
    stateVersion = 5;
  };

  determinateNix = {
    enable = true;


    customSettings = {
      eval-cores = 0;
      warn-dirty = false;
      lazy-trees = true;

      # Cache
      trusted-users = [ "root" "@admin" username ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}