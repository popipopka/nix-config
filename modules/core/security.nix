{ pkgs, username, config, ... }:
{
  security = {
    rtkit.enable = true;

    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if ( subject.isInGroup("users") && (
           action.id == "org.freedesktop.login1.reboot" ||
           action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
           action.id == "org.freedesktop.login1.power-off" ||
           action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          ))
          { return polkit.Result.YES; }
        })
      '';
    };
    
    #enableWrappers = true;
    #wrappers = {
    #  nekoray = {
    #    source = "${pkgs.nekoray}/bin/nekoray";
    #    owner = "${username}";
    #    group = "users";
    #    capabilities = "cap_net_admin+ep";
    #    #permissions = "755";
    #  };
    #};
  };
}
