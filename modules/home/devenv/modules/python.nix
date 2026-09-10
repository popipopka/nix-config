{ lib, ... }:
{
  languages.python = {
    enable = true;
    uv.enable = true;
    venv.enable = true;
  };

  dotenv.enable = lib.mkDefault true;
}
