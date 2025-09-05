{ lib, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      font = lib.mkForce "Montserrat Light 9";
      default-timeout = 1000 * 7; # 7сек
      border-size = 1;
      padding = 8;
      margin = 8;
      border-radius = 5;
      max-icon-size = 48;
    };
  };
}