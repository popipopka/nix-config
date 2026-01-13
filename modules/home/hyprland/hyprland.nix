{ host
, config
, pkgs
, ...
}:
let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    keyboardLayout
    stylixImage
    ;
in
{
  home.packages = with pkgs; [
      swww
      wl-clipboard
      cliphist
      brightnessctl
      hyprpolkitagent
      hyprland-qtutils
      hyprshot
      hyprnotify
#      swappy
    ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
      "xdg-desktop-autostart.target"
    ];

  home.file = {
     "Pictures/Wallpapers" = {
       source = ../../../wallpapers;
       recursive = true;
     };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };

    xwayland = {
      enable = true;
    };
    
    extraConfig = "
      layerrule = noanim,^(rofi)$
    ";

    settings = {

      monitor = [ ", 1366x768@60, 0x0, 1" ];

      input = {
        kb_layout = "${keyboardLayout}";
        kb_options = "grp:win_space_toggle";

        numlock_by_default = true;
        repeat_delay = 300;
        follow_mouse = 1;
        float_switch_override_focus = 0;
        sensitivity = 0;
        touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            scroll_factor = 0.25;
        };
      };

      gestures = {
        #workspace_swipe = 1;
        #workspace_swipe_fingers = 3;
        workspace_swipe_distance = 500;
        workspace_swipe_invert = 1;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = 1;
        workspace_swipe_forever = 1;
      };

      general = {
        layout = "dwindle";
        gaps_in = 2;
        gaps_out = 2;
        border_size = 1;
        "col.active_border" = "rgba(1a1a1aaa)";
        "col.inactive_border" = "rgba(1a1a1aaa)";
        allow_tearing = false;
      };

      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = false;
        force_default_wallpaper = -1;
        vfr = true;
        enable_anr_dialog = true;
        anr_missed_pings = 15;
      };

      dwindle = {
        pseudotile = false;
        preserve_split = false;
      };

      decoration = {
        rounding = 8;
        dim_inactive = true;
        dim_strength = 0.1;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = false;
        };
      };

      ecosystem = {
        no_donation_nag = true;
        no_update_news = false;
      };

      cursor = {
        sync_gsettings_theme = true;
        no_hardware_cursors = 2; # change to 1 if want to disable
        enable_hyprcursor = false;
        warp_on_change_workspace = 2;
        no_warps = true;
      };

      render = {
        direct_scanout = 0;
      };
      
      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
}
