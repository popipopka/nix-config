{pkgs, ...}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

#    loader.grub = {
#      enable = true;
#      device = "/dev/sda";
#      useOSProber = true;
#    };

#    supportedFilesystems = [ "ntfs" ];
  };
}
