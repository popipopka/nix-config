{
  pkgs,
  lib,
  config,
  ...
}:
{
  languages = {
    java = {
      enable = true;
      jdk.package = pkgs.jdk21;
    };
  };

  packages = [
    pkgs.gradle
  ];

  dotenv.enable = true;
}
