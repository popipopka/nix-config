{ pkgs, inputs, username, macbook, ... }:
{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";

    extraSpecialArgs = { inherit inputs username macbook; };

    users.${username} = {
      imports = [ ./../home ];
      home = {
        username = "${username}";
        homeDirectory = "/Users/${username}";
        stateVersion = "25.11";
      };
    };
  };

  programs.fish.enable = true;
  users.users.${username} = {
    home = "/Users/${username}";

    shell = pkgs.fish;
  };
}
