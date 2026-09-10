{ pkgs, inputs, config, lib, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    allowCollisions = true;
  };

  environment = {
    systemPackages = with pkgs; [
      bun

      pandoc  # Docs converter
      typst   # PDF engine for pandoc
      poppler-utils # PDF utils
      plantuml
    ];

    shells = with pkgs; [
      fish
    ];
  };
}
