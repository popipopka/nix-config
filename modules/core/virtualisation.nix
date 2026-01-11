{ pkgs, pkgsUnstable, ... }:
{
  # Либо podman, либо docker - нельзя одновременно
  
  # Отключаем KVM для работы VirtualBox
  boot.blacklistedKernelModules = [ "kvm" "kvm_intel" "kvm_amd" ];

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
    virtualbox = {
      host = {
        enable = false;
        enableExtensionPack = false;
      };
      guest = {
        enable = false;
        clipboard = false;
        dragAndDrop = false;
        vboxsf = false;
      };
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
    docker-buildx
    dive
  ];
}
