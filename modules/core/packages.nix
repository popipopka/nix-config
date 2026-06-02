{ pkgs, inputs, config, lib, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    allowCollisions = true;
  };

  environment = {
    systemPackages = with pkgs; [
      devenv
      pandoc  # Docs converter
      poppler # PDF utils
    ];

    shells = with pkgs; [
      fish
    ];
  };
}
