{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    allowCollisions = true;
  };

  environment = {
    systemPackages = with pkgs; [
      nixd

      bun

      pandoc  # Docs converter
      typst   # PDF engine for pandoc
      poppler-utils # PDF utils
      plantuml

      ripgrep
    ];

    shells = with pkgs; [
      fish
    ];
  };
}
