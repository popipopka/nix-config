{ host, ... }:
{
  imports = [
    ./boot.nix
    ./cachix.nix
    ./hardware.nix
    ./network.nix
    ./nh.nix
    ./packages.nix
    ./services.nix
    ./ssh.nix
    ./system.nix
    ./user.nix
    ./zram.nix
  ];
}
