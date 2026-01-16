{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    
    matchBlocks = {
      "gitlab.com" = {
        hostname = "gitlab.com"
        user = "git"
        identityFile = "~/.ssh/git"
      };
    };
  };
}