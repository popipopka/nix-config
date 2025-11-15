{
  programs.kitty = {
    enable = true;

    settings = {
      # Font
      font_family = "JetBrains Mono NL ExtraLight";
      bold_font = "JetBrains Mono NL SemiBold";
      italic_font = "JetBrains Mono NL Light Italic";
      bold_italic_font = "JetBrains Mono NL SemiBold Italic";

      # Scrollback
      scrollback_lines = 10000;
      touch_scroll_multiplier = 4.0;

      # Mouse
      mouse_hide_wait = 0;

      # Window
      remember_window_size = "no";
      initial_window_width = "98c";
      initial_window_height = "24c";
      confirm_os_window_close = 0;
      window_border_width = "0pt";

      # Tabs
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
    };

    # Shortcuts
    extraConfig = ''
      map kitty_mod                 ctrl+shift;
      map clear_all_shortcuts       yes;

      # Clipboard
      map kitty_mod+c 				copy_to_clipboard
	    map kitty_mod+v 				paste_from_clipboard

	    # Scrolling
	    map kitty_mod+up    			scroll_line_up
	    map kitty_mod+down    		scroll_line_down
	    map kitty_mod+home 			scroll_home
	    map kitty_mod+end 			scroll_end

	    # Tab
	    map alt+t				        new_tab
	    map alt+q				        close_tab
	    map alt+tab				    next_tab
    '';
  };
}
