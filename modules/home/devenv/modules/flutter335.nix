{ pkgs, ... }:
{
  imports = [ ./flutter.nix ];

  android.flutter.package = pkgs.flutter335;
}
