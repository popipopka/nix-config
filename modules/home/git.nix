{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername gitEmail;
in
{
  programs.git = {
    enable = true;

    userName = "${gitUsername}";
    userEmail = "${gitEmail}";

    extraConfig = {
      push.default = "simple";
      credential.helper = "cache --timeout=7200";
      init.defaultBranch = "main";
      log.decorate = "full";
      log.date = "iso";
      merge.conflictStyle = "diff3";
    };

    aliases = {
      git = "LANG=en_US.UTF-8 git";
      
      gcl = "clone";
      gsw = "switch";
      gm = "merge";
      
      gl = "log --pretty=format:'%C(yellow)commit %C(auto)%h%d %C(green)(%cr) %C(cyan)<%an> %n%n      %Creset%s%n' --date=relative";
      glg = "log --graph --pretty=format:'%C(yellow)commit %C(auto)%h%d %C(green)(%cr) %C(cyan)<%an> %n%n      %Creset%s%n' --date=relative";
      glo = "log --oneline";
      glog = "log --oneline --graph";
      
      gs = "status --short";
      ga = "add";
      grs = "reset";
      grsh = "reset --hard";
      
      gcm = "commit -m";
      gca = "commit --ammend";
      
      gpl = "pull origin";
      gps = "push origin";
      gpsu = "push -u origin main";
      gpsf = "push origin --force";
    };
  };
}
