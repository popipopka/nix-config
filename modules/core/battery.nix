{ config, pkgs, ... }:

{
  # Оптимизация планировщика
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  # Управление питанием
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1; # на питании от сети TurboBoost включён
      CPU_BOOST_ON_BAT = 0; # на батарее TurboBoost выключен
      CPU_SCALING_GOVERNOR_ON_AC = "performance"; # на сети режим performance
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave"; # на батарее режим powersave
    };
  };
  
#  powerManagement.powertop.enable = true; # автоматическая оптимизация энергопотребления
  services.upower.enable = true; # подсистема управления питанием для laptop
}
