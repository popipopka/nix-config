{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername gitEmail;
in
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "${gitUsername}";
        email = "${gitEmail}";
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      init = {
        defaultBranch = "main";
      };

      log = {
        decorate = "full";
        date = "iso";
      };

      merge = {
        conflictStyle = "diff3";
      };

      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
        "git@gitlab.com:" = {
          insteadOf = "https://gitlab.com/";
        };
      };
    };
  };

  home.shellAliases = {
    gcl = "git clone";
    gsw = "git switch";
    gswc = "git switch -c";

    gl = "git log --pretty=format:'%C(yellow)commit %C(auto)%h%d %C(green)(%cr) %C(cyan)<%an> %n%n      %Creset%s%n' --date=relative";
    glg = "git log --graph --pretty=format:'%C(yellow)commit %C(auto)%h%d %C(green)(%cr) %C(cyan)<%an> %n%n      %Creset%s%n' --date=relative";
    glo = "git log --oneline";
    glog = "git log --oneline --graph";

    gs = "git status --short";
    ga = "git add";
    grs = "git reset";
    grsh = "git reset --hard";
    grss = "git reset --soft";

    gcm = "git commit -m";
    gca = "git commit --ammend";

    gpl = "git pull origin";
    gps = "git push origin";
    gpsu = "git push -u origin main";
    gpsf = "git push origin --force";
    
    gst = "git stash";
    gstp = "git stash pop";
    
    grb = "git rebase";
    gmr = "git merge";

    gcp = "git cherry-pick";
    gcpn = "git cherry-pick -n";
  };
}
