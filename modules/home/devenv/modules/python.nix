{ lib, ... }:
{
  languages.python = {
    enable = true;
    uv.enable = true;
    venv.enable = true;
  };

  dotenv.enable = lib.mkDefault true;

  enterShell = ''
    # Create a symlink to the Python virtual environment for IDE compatibility
    if [ ! -L "$DEVENV_ROOT/venv" ]; then
      ln -s "$DEVENV_STATE/venv/" "$DEVENV_ROOT/venv"
    fi
  '';
}
