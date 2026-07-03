{ inputs, host, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../disko-config.nix

    ../../hosts/${host}/hardware.nix
    ../../modules/core
  ];
}
