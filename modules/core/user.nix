{ pkgs, inputs, username, host, profile, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername;
in
{
  # Home manager
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = false;
    backupFileExtension = "backup";

    extraSpecialArgs = { inherit inputs username host profile; };

    users.${username} = {
      imports = [ ./../home ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "23.11";
      };
    };
  };

  # Пользователь
  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";

    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;

    extraGroups = [
      "adbusers"
      "docker" #access to docker as non-root
      "libvirtd" #Virt manager/QEMU access
      "lp"
      "networkmanager"
      "scanner"
      "wheel" #sudo access
      "vboxusers" #Virtual Box
    ];
  };

  # Ограничение доступа к nix
  nix.settings.allowed-users = [
    "${username}"
  ];
}
