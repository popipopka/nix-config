{ pkgs, lib, ... }:
{
  android = {
    enable = true;

    emulator.enable = lib.mkDefault false;
    systemImages.enable = lib.mkDefault false;

    flutter = {
      enable = true;
      package = lib.mkDefault pkgs.flutter;
    };
  };

  dotenv.enable = lib.mkDefault true;
}
