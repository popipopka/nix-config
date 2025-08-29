{ inputs, ... }: 
{
  stylix.targets = {
    waybar.enable = false;
    rofi.enable = false;
    hyprland.enable = false;
    hyprlock.enable = false;

    qt = {
      enable = true;
      platform = "qtct";
    };
  };
}
