{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../disko-config.nix

    ./hardware.nix
    ../../modules/core
    ../../modules/deploy
    
    ./virtualisation.nix
  ];
}
