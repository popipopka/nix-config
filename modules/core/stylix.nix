{ pkgs, host, inputs, ...}:
let
  inherit (import ../../hosts/${host}/variables.nix) stylixImage;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  
  disabledModules = [
    "${inputs.stylix}/modules/anki/hm.nix"
    "${inputs.stylix}/modules/gnome/nixos.nix"
  ];
  
  stylix = {
    enable = true;
    #image = stylixImage;

    polarity = "dark";
    opacity.terminal = 0.95;

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 22;
    };
    
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Light";
    };
    
    base16Scheme = {
      base00 = "#1e1e2e"; # base
      base01 = "#181825"; # mantle
      base02 = "#313244"; # surface0
      base03 = "#45475a"; # surface1
      base04 = "#585b70"; # surface2
      base05 = "#cdd6f4"; # text
      base06 = "#f5e0dc"; # rosewater
      base07 = "#b4befe"; # lavender
      base08 = "#f38ba8"; # red
      base09 = "#fab387"; # peach
      base0A = "#f9e2af"; # yellow
      base0B = "#a6e3a1"; # green
      base0C = "#94e2d5"; # teal
      base0D = "#89b4fa"; # blue
      base0E = "#cba6f7"; # mauve
      base0F = "#f2cdcd"; # flamingo
    };


    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono NL";
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
        applications = 11;
        terminal = 9;
        desktop = 11;
        popups = 11;
      };
    };
  };
}
