{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    
    extraConfig = {
      modi = "drun,filebrowser";        
      show-icons = true;
      icon-theme = "Papirus";
      font = "JetBrainsMono Nerd Font Mono 11";
      drun-display-format = "{icon} {name}";
      display-drun = " Apps";
      display-filebrowser = " File";
    };

    
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          bg = mkLiteral "${config.stylix.base16Scheme.base00}";
          bg-alt = mkLiteral "${config.stylix.base16Scheme.base09}";
          foreground = mkLiteral "${config.stylix.base16Scheme.base01}";
          selected = mkLiteral "${config.stylix.base16Scheme.base08}";
          active = mkLiteral "${config.stylix.base16Scheme.base0B}";
          text-selected = mkLiteral "${config.stylix.base16Scheme.base00}";
          text-color = mkLiteral "${config.stylix.base16Scheme.base05}";
          border-color = mkLiteral "${config.stylix.base16Scheme.base0F}";
          urgent = mkLiteral "${config.stylix.base16Scheme.base0E}";

          font = "JetBrains Mono NL 9";
        };
        
        "window" = {
          transparency = "real";
          padding = mkLiteral "10px";
          width = mkLiteral "800px";
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          fullscreen = false;
          x-offset = mkLiteral "0px";
          y-offset = mkLiteral "0px";
          cursor = "default";
          enabled = true;
          border-radius = mkLiteral "25px";
          background-color = mkLiteral "@bg";
        };
        "mainbox" = {
          enabled = true;
          spacing = mkLiteral "10px";
          orientation = mkLiteral "vertical";
          children = map mkLiteral [
            "inputbar"
            "listbox"
            "mode-switcher"
          ];
          background-color = mkLiteral "transparent";
        };
        "inputbar" = {
          enabled = true;
          spacing = mkLiteral "10px";
          padding = mkLiteral "8px";
          border-radius = mkLiteral "15px";
          background-color = mkLiteral "@bg-alt";
          text-color = mkLiteral "@foreground";
          children = map mkLiteral [
            "textbox-prompt-colon"
            "entry"
          ];
        };
        "listbox" = {
          spacing = mkLiteral "10px";
          background-color = mkLiteral "transparent";
          orientation = mkLiteral "vertical";
          children = map mkLiteral [
            "message"
            "listview"
          ];
        };
        "textbox-prompt-colon" = {
          enabled = true;
          expand = false;
          str = "";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "entry" = {
          enabled = true;
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "text";
          placeholder = "Search";
          placeholder-color = mkLiteral "inherit";
        };
        "mode-switcher" = {
          enabled = true;
          spacing = mkLiteral "10px";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
        };
        "button" = {
          padding = mkLiteral "8px";
          border-radius = mkLiteral "20px";
          background-color = mkLiteral "@bg-alt";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "pointer";
        };
        "button selected" = {
          background-color = mkLiteral "@selected";
          text-color = mkLiteral "@foreground";
        };
        "listview" = {
          enabled = true;
          columns = 2;
          lines = 6;
          cycle = true;
          scrollbar = false;
          layout = mkLiteral "vertical";
          reverse = false;
          fixed-height = true;
          fixed-columns = true;
          spacing = mkLiteral "5px";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
          cursor = "default";
        };
        "element" = {
          enabled = true;
          spacing = mkLiteral "5px";
          padding = mkLiteral "5px";
          border-radius = mkLiteral "10px";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@text-color";
          cursor = mkLiteral "pointer";
        };
        "element normal.normal" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "@text-color";
        };
        "element normal.urgent" = {
          background-color = mkLiteral "@urgent";
          text-color = mkLiteral "@text-color";
        };
        "element normal.active" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "@text-color";
        };
        "element selected.normal" = {
          background-color = mkLiteral "@selected";
          text-color = mkLiteral "@foreground";
        };
        "element selected.urgent" = {
          background-color = mkLiteral "@urgent";
          text-color = mkLiteral "@text-selected";
        };
        "element selected.active" = {
          background-color = mkLiteral "@urgent";
          text-color = mkLiteral "@text-selected";
        };
        "element-icon" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          size = mkLiteral "24px";
          cursor = mkLiteral "inherit";
        };
        "element-text" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
        "message" = {
          background-color = mkLiteral "transparent";
        };
        "textbox" = {
          padding = mkLiteral "5px";
          border-radius = mkLiteral "10px";
          background-color = mkLiteral "@bg-alt";
          text-color = mkLiteral "@foreground";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
        "error-message" = {
          padding = mkLiteral "15px";
          border-radius = mkLiteral "20px";
          background-color = mkLiteral "@bg";
          text-color = mkLiteral "@foreground";
        };
      };
  };
}
