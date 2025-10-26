{ host, ... }:
{
  imports = [
    ../../hosts/${host}
    ../../modules/drivers
    ../../modules/core
  ];

  drivers.nvidia.enable = true;

  drivers.amdgpu.enable = false;
  drivers.intel.enable = false;
  vm.guest-services.enable = false;
}

