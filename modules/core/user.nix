{ pkgs, inputs, host, ... }:
{
  # Home manager
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";

    extraSpecialArgs = { inherit inputs host; };

    users.root = {
      imports = [ ./../home ];
      home = {
        username = "root";
        homeDirectory = "/root";
        stateVersion = "23.11";
      };
    };
  };

  users.users.root = {
    shell = pkgs.fish;
  };

  # Ограничение доступа к nix
  nix.settings.allowed-users = [
    "root"
  ];
}
