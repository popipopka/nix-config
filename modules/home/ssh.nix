{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    
    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/git";
        AddKeysToAgent = "yes";
      };

      "gitlab.com" = {
        HostName = "gitlab.com";
        User = "git";
        IdentityFile = "~/.ssh/git";
        AddKeysToAgent = "yes";
      };

      "gitlab.fittin.ai" = {
        HostName = "gitlab.fittin.ai";
        User = "git";
        IdentityFile = "~/.ssh/git";
        AddKeysToAgent = "yes";
      };

      "*" = {
        ServerAliveInterval = 30;
        ServerAliveCountMax = 3;
        IdentityFile = "~/.ssh/main";
        AddKeysToAgent = "yes";
      };
    };
  };
}