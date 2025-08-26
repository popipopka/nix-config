{
    disko.devices = {
        disk = {
            main = {
                type = "disk";
                device = "/dev/sda";
                content = {
                    type = "gpt";
                    partitions = {
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
                            size = "12G";
                            type = "8200";

                            content = {
                                type = "swap";
                                resumeDevice=true;
                            };
                        };

                        root = {
                            size = "100%";
                            content = {
                                type = "btrfs";
                                extraArgs = [ "-f" ];
                                mountpoint = "/";

                                subvolumes = {
                                    "/home" = {
                                        mountOptions = [ "compress=zstd" ];
                                        mountpoint = "/home";
                                    };
                                    "/nix" = {
                                        mountOptions = [ "compress=zstd" "noatime" ];
                                        mountpoint = "/nix";
                                    };
                                    "/var" = {
                                        mountOptions = [ "compress=zstd" "noatime" "autodefrag" ];
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
                mountOptions = [ "size=1G" "noexec" "nosuid" "mode=1777" "relatime" ];
            };
        };
    };
}
