{host, ...}:
let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    extraMonitorSettings
    ;
in
{
  wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        #---- Browser -----------------------------
#        "tag +browser, class:^(Brave-browser(-beta|-dev|-unstable)?)$"
#        "tag +browser, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
#        "tag +browser, class:^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"
#        "tag +browser, class:^([Tt]horium-browser|[Cc]achy-browser)$"
#
#        "workspace 5 silent, tag:browser*"


        #---- File Manager ------------------------
#        "tag +file-manager, class:^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt|[Nn]emo)$"

#         "float, tag:file-manager*"


        #---- Obsidian ----------------------------
#        "workspace special:magic silent, class:(obsidian)"


        #---- JetBrains IDE`s ---------------------
#        "workspace 6 silent, class:^(jetbrains-.*)$"
#        "nodim, class:^(jetbrains-.*)$"


        #---- JetBrains Toolbox -------------------
#        "workspace 6 silent, class:(com-jetbrains-toolbox-entry-ToolboxEntry)"
#        "nodim, class:(com-jetbrains-toolbox-entry-ToolboxEntry)"


        #---- telegram ----------------------------
#        "workspace 4 silent, class:(org.telegram.desktop)"


        #---- qimgv -------------------------------
#        "float, class:(qimgv)"


        #---- kitty -------------------------------
#        "float, class:^(kitty)$"
#        "move cursor -50% -50%, class:^(kitty)$"
#        "opacity 0.82 override 0.7 override 1.0 override, class:^(kitty)$"


        #---- NetworkManager ----------------------
#        "pin, title:(nmtui)"


        #---- file roller -------------------------
#        "float, class:(org.gnome.FileRoller)"
#        "size 44% 63%, class:(file-roller), title:(Extract)"


        #---- rofi --------------------------------
#        "float, class:(Rofi)"
#        "noborder, class:(Rofi)"
#        "pin, class:(Rofi)"

        #---- xreader -----------------------------
#        "float, title:(Document Viewer)"

        #---- polkit-gnome-authentication-agent -----
#        "float,class:^(org.gnome.polkit-gnome-authentication-agent-1)$"

        #---- xwaylandvideobridge -----------------
#        "opacity 0.0 override 0.0 override, class:^(xwaylandvideobridge)$"
#        "noanim, class:^(xwaylandvideobridge)$"
#        "noinitialfocus, class:^(xwaylandvideobridge)$"
#        "maxsize 100 100, class:^(xwaylandvideobridge)$"
#        "noblur, class:^(xwaylandvideobridge)$"
      ];
    };
}