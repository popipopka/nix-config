{ lib, ... }:
{
  languages.javascript = {
    enable = true;
    npm.enable = lib.mkDefault true;
  };

  dotenv.enable = lib.mkDefault true;
}
