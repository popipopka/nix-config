{ pkgs, lib, host, config, ... }:
{
programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [
          "custom/power"
    	  "network"
    	  "battery"
    	  "tray"
        ];

        modules-center = [];

        modules-right = [
          "backlight"
    	  "pulseaudio"
    	  "clock"
        ];

        "custom/power" = {
          format = " ";
          on-click = "wlogout";
          tooltip = false;
        };

        "pulseaudio" = {
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%-";
          on-scroll-down = "wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+";
          scroll-step = 5;

          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };

          "min-length" = 8;
        };

        "network" = {
          tooltip = false;

          interval = 5;

          format = "{ifname}";
          format-wifi = "{icon} {essid} ({signalStrength}%)";
          format-ethernet = "Ethernet {ipaddr}/{cidr}";
          format-disconnected = "Disconnected";

          format-icons = [ "󰢿 " "󰢼 " "󰢽 " "󰢾 " ];

          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "Wi-Fi  {essid}";
          tooltip-format-ethernet = "Ethernet  {ifname}";
          tooltip-format-disconnected = "Disconnected";

          max-length = 50;
          min-length = 8;

          on-click = "kitty -e nmtui";
        };

        "tray" = {
          icon-size = 16;
          spacing = 10;
          show-passive-items = true;
        };

        "clock" = {
          tooltip = false;
          format = "<span>{:%a; %e %b   %R}</span>";
          timezone = "Europe/Moscow";
        };

        "battery" = {
          tooltip = false;

          interval = 10;

          states = {
            warning = 40;
            critical = 20;
          };

          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];

          min-length = 8;
        };

        "backlight" = {
          tooltip = false;

          device = "intel_backlight";

          format = "{icon} {percent}%";
          format-icons = ["󰃞 " " " " " " " "󰃟 " " " " " " " "󰃠 " ];

          on-scroll-up = "brightnessctl set 7%-";
          on-scroll-down = "brightnessctl set 7%+";

          min-length = 8;
        };
      };
    };

    style = lib.concatStrings [
      ''
        * {
            border: none;
            border-radius: 0px;
            font-family: "JetBrainsMono Nerd Font";
            font-weight: bold;
            font-size: 12px;
            min-height: 0px;
        }
        window#waybar {
            background: rgba(0, 0, 0, 0);
            color: #d7dfff;
        }
        #bluetooth,
        #battery,
        #pulseaudio,
        #backlight,
        #network,
        #clock,
        #custom-divider,
        #tray,
        #custom-power {
            background: rgba(0, 0, 0, 0);
            padding: 0px 8px;
            margin-top: 2px;
            margin-bottom: 0px;
            margin-left: 0px;
            margin-right: 0px;
        }
        #custom-power {
            margin-left: 7px;
        }
        #battery.warning:not(.charging) {
            color: #ff8c40;
        }
        #battery.critical:not(.charging) {
            color: #c4423b;
        }
        #tray {
            margin-top: 2px;
        }
        #tray menu {
            border-radius: 10px;
            opacity: 0.9;
        }
        #clock {
            margin-right: 7px;
        }
      ''
    ];
  };
}
