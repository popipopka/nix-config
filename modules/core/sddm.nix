# SDDM is a display manager for X11 and Wayland
{ pkgs, config, lib, ... }: {
  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      extraPackages = [sddm-astronaut];
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
    };
  };

  environment.systemPackages = [sddm-astronaut];
}
