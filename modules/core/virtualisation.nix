{ pkgs, ... }:
{
  # Либо podman, либо docker - нельзя одновременно

  virtualisation = {
    # Docker
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };

    # VirtualBox
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };

    # Podman
    podman.enable = false;

    # Демон для KVM/QEMU виртуализации
    libvirtd.enable = false;
  };

  programs = {
    virt-manager.enable = false;
  };

  # Доп. пакеты, связанные с виртуализацией/контейнеризацией
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
