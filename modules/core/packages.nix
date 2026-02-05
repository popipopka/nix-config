{ pkgs, inputs, config, lib, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    allowCollisions = true;
  };

  environment = {
    systemPackages = with pkgs; [
      devenv
    ];

    shells = with pkgs; [
      fish
    ];
  };
}
