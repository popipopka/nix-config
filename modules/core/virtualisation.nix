{ pkgs, ... }:
{
  # Либо podman, либо docker - нельзя одновременно

  virtualisation = {
    # Docker
    docker = {
      enable = true;
      storageDriver = "btrfs";
      autoPrune = {
        enable = true;
        dates = "monthly";
      };
    };

    # VirtualBox
    virtualbox.host = {
      enable = false;
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
