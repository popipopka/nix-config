{ host, ... }:

let
    variables = import ./hosts/${host}/variables.nix;
in
{
    disko.devices = {
        disk = {
            main = {
                type = "disk";
                device = variables.disk;
                content = {
                    type = "gpt";
                    partitions = {
                        bios = {
                            priority = 0;
                            start = "1M";
                            end = "2M";
                            type = "EF02";
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
