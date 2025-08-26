{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    plugins = [pkgs.rofimoji];

#    configPath = "./config/config.nix";
  };
}
