{ ... }:
{
  imports = [
    ./amd-drivers.nix
    ./intel-drivers.nix
    ./local-hardware-clock.nix
    ./nvidia-drivers.nix
    ./vm-guest-services.nix
  ];
}
