{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/git";
        addKeysToAgent = "yes";
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/git";
        addKeysToAgent = "yes";
      };

      "gitlab.fittin.ai" = {
        hostname = "gitlab.fittin.ai";
        user = "git";
        identityFile = "~/.ssh/git";
        addKeysToAgent = "yes";
      };

      "*" = {
        serverAliveInterval = 30;
        serverAliveCountMax = 3;
        identityFile = "~/.ssh/main";
        addKeysToAgent = "yes";
      };
    };
  };
}