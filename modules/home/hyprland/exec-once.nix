{ host, ... }:
let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    stylixImage
    ;
in
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      #---- Important ---------------------------
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user start hyprpolkitagent"

      #---- Apps --------------------------------
      "google-chrome-stable"
      "Telegram"
      "AmneziaVPN"
      
      # Daemon's
      "killall -q swww;sleep .5 && swww-daemon && swww img ${stylixImage}"

      #---- Other -------------------------------
      "killall -q waybar;sleep .5 && waybar"

      #---- OSD ---------------------------------
      "sh -c 'rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob'"

      #---- Clipboard ---------------------------
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];
  };
}
