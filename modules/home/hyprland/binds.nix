{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$ctrlMod" = "SUPER CTRL";
    "$shiftMod" = "SUPER SHIFT";
    
    bind = [
      #---- Скриншоты ---------------------------
      "$shiftMod, PRINT, exec, hyprshot -m output --freeze -t 1700"
      ", PRINT, exec, hyprshot -m region --freeze -t 1700"
      "$mainMod, PRINT, exec, hyprshot -m window --freeze -t 1700"

      #---- Запуск приложений -------------------
      "$mainMod, n, exec, kitty"
      "$mainMod, r, exec, rofi-launcher"

      #---- Буфер обмена ------------------------
      "$mainMod, tab, exec, rofi-clipboard"
      "$shiftMod, tab, exec, pkill rofi || cliphist wipe"

      #---- Действия над системой ---------------
      "$shiftMod, f1, exit"

      #---- Действия над активными окнами -------
      "$mainMod, q, killactive"
      "$mainMod, f, fullscreen, 1"
      "$shiftMod, f, fullscreen, 0"
      "$mainMod, v, togglefloating, 1"
      "$shiftMod, v, workspaceopt, allfloat"

      #---- Смена фокуса ------------------------
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      #---- Смена столов -------------------------
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"

      "$mainMod, e, workspace, 5"
      "$mainMod, d, workspace, 6"

      "$mainMod, s, togglespecialworkspace, magic"

      #---- Перенос приложений --------------------
      "$shiftMod, 1, movetoworkspace, 1"
      "$shiftMod, 2, movetoworkspace, 2"
      "$shiftMod, 3, movetoworkspace, 3"
      "$shiftMod, 4, movetoworkspace, 4"

      "$shiftMod, e, movetoworkspace, 5"
      "$shiftMod, d, movetoworkspace, 6"

      "$shiftMod, s, movetoworkspace, special:magic"
    ];
    
    bindm = [
      #--- Мышь ---------------------------------
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
      #--- Изменение звука ----------------------
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+ && wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/[^0-9]//g' > $WOBSOCK"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%- && wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/[^0-9]//g' > $WOBSOCK"


     #--- Изменение яркости --------------------
     ", XF86MonBrightnessUp, exec, brightnessctl set 7%+ | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK"
     ", XF86MonBrightnessDown, exec, brightnessctl set 7%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK"
    ];
  };
}

  
