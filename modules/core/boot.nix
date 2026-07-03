{ ... }:
{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernel.sysctl = {
      "fs.file-max" = 2097152;
      "net.core.somaxconn" = 4096;

      "net.ipv4.ip_forward" = 1;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.tcp_fin_timeout" = 15;
      "net.ipv4.tcp_keepalive_time" = 600;
      "net.ipv4.tcp_tw_reuse" = 1;

      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 20;
      "vm.swappiness" = 10;
    };

    kernelModules = [ "tcp_bbr" ];

    supportedFilesystems = [ "btrfs" "ext4" "xfs" "ntfs" ];
  };
}
