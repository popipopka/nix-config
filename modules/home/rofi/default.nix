{ pkgs, ... }:
{
  imports = [
    ./config.nix
    ./rofi.nix
  ];
  
  home.packages = [
    (import ./rofi-launcher.nix { inherit pkgs; })
    (import ./rofi-clipboard.nix { inherit pkgs; })
  ];
}
