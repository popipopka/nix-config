{ host, ... }:
{
  imports = [
    ../../hosts/${host}
    ../../modules/drivers
    ../../modules/core
  ];

  vm.guest-services.enable = true;

  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = false;
  drivers.intel.enable = false;
}
