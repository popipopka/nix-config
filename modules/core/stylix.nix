{ pkgs, host, ...}:
let
  inherit (import ../../hosts/${host}/variables.nix) stylixImage;
in
{
  stylix = {
    enable = true;
    image = stylixImage;

    polarity = "dark";
    opacity.terminal = 1.0;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      
      sizes = {
        applications = 12;
        terminal = 11;
        desktop = 11;
        popups = 12;
      };
    };
  };
}
