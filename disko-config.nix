{
    disko.devices = {
        disk = {
            main = {
                type = "disk";
                device = "/dev/sda";
                content = {
                    type = "gpt";
                    partitions = {
                        bios = {
                            priority = 0;
                            size = "1M";
                            type = "EF02";
                        };

                        ESP = {
                            priority = 1;
                            name = "ESP";
                            type = "ef00";

                            start = "1M";
                            end = "512M";

                            content = {
                                type = "filesystem";
                                format = "vfat";
                                mountpoint = "/boot";
                                mountOptions = [ "umask=0077" ];
                            };
                        };

                        swap = {
                            name = "swap";
                            size = "2G";
                            type = "8200";

                            content = {
                                type = "swap";
                            };
                        };

                        root = {
                            size = "100%";
                            content = {
                                type = "btrfs";
                                extraArgs = [ "-f" ];

                                subvolumes = {
                                    "/@" = {
                                        mountOptions = [ "compress=zstd" "noatime" ];
                                        mountpoint = "/";
                                    };
                                    "/@root" = {
                                        mountOptions = [ "compress=zstd" "noatime" ];
                                        mountpoint = "/root";
                                    };
                                    "/nix" = {
                                        mountOptions = [ "compress=zstd" "noatime" ];
                                        mountpoint = "/nix";
                                    };
                                    "/var" = {
                                        mountOptions = [ "compress=zstd" "noatime" ];
                                        mountpoint = "/var";
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };

        nodev = {
            "/tmp" = {
                device = "tmpfs";
                fsType = "tmpfs";
                mountOptions = [ "size=2G" "noexec" "nodev" "nosuid" "mode=1777" "relatime" ];
            };
        };
    };
}
