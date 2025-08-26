{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

#    drivers.intel.enable = true;
#    supportedFilesystems = [ "ntfs" ];
  };
}
