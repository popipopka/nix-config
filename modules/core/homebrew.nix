{ username, inputs, ... }: {
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;

      cleanup = "none";
    };

    taps = [];
    brews = [];
    casks = [];
  };

  nix-homebrew = {
    enable = true;
    user = "${username}";

    enableRosetta = false; # Пока что не требуется
    autoMigrate = true;
    mutableTaps = true;
  };
}