{ pkgs }:
pkgs.writeShellScriptBin "rofi-clipboard" ''
  # check if rofi is already running
  if pidof rofi > /dev/null; then
    pkill rofi
  fi
  cliphist list | rofi -dmenu -display-columns 2 -theme clipboard | cliphist decode | wl-copy
''

