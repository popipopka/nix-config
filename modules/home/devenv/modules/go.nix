{ lib, ... }:
{
  languages.go.enable = true;

  dotenv.enable = lib.mkDefault true;
}
