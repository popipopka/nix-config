{ pkgs, username, ...}:
{
  services.greetd = {
    enable = false;
#    vt = 3;

    settings = {
      default_session = {
        user = username;
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };
}

