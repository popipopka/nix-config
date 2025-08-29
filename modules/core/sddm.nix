{ pkgs, username, ...}:
let
  sddm-catppucin = pkgs.catppuccin-sddm.override {
    flavor = "mocha";
    loginBackground = false;
    font = "Montserrat";
    fontSize = "9";
  };
in {
  environment.systemPackages = [ sddm-catppucin ];
  
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      
      package = pkgs.kdePackages.sddm;
      
      theme = "catppuccin-mocha";
    };
  };
}

