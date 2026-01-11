{host, ...}:
{
  wayland.windowManager.hyprland.settings = {
      windowrule = [
        #---- Browser -----------------------------
        "tag +browser, class:^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"

        "workspace 5 silent, tag:browser*"


        #---- File Manager ------------------------
        "tag +file-manager, class:^([Nn]emo)$"

        "float, tag:file-manager*"


        #---- Obsidian ----------------------------
        "workspace special:magic silent, class:(obsidian)"


        #---- JetBrains IDE`s ---------------------
        "tag +jetbrains, class:^(jetbrains-.*)$"
        
        "workspace 6 silent, tag:jetbrains*"
        "nodim, tag:jetbrains"


        #---- Telegram ----------------------------
        "workspace 4 silent, class:^(.*telegram.*)$"


        #---- VPN ---------------------------------
        "workspace 4 silent, title:^(AmneziaVPN)$"


        #---- Terminal ----------------------------
        "tag +terminal, class:^(kitty)$"
        
        "float, tag:terminal*"
        "move cursor -50% -50%, tag:terminal*"
        "opacity 0.82 override 0.7 override 1.0 override, tag:terminal*"


        #---- NetworkManager ----------------------
        "pin, title:(nmtui)"


        #---- File roller -------------------------
        "float, class:(org.gnome.FileRoller)"
        "size 44% 63%, class:(file-roller), title:(Extract)"
      ];
    };
}
