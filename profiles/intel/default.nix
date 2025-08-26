{ host, ... }:
{
  imports = [
    ../../hosts/${host}
    ../../modules/drivers
    ../../modules/core
  ];

  drivers.intel.enable = true;

  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = false;
  vm.guest-services.enable = false;
}
