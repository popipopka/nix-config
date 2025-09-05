{ ... }: {
  home.file.".local/share/rofi/themes/clipboard.rasi".text = ''
    @import "~/.config/rofi/config.rasi"
    listview {
        columns: 1;
        lines: 10;
    }
    element-icon {
        enabled: false;
    }
  '';
}
