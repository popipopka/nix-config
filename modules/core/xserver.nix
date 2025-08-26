{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) keyboardLayout;
in
{
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };

#    displayManager.gdm.enable = false;
#    desktopManager.gnome.enable = false;
  };
}
