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
    brews = [
      "node"
    ];
    casks = [];
  };

  nix-homebrew = {
    enable = true;
    user = "${username}";

    enableRosetta = true;
    autoMigrate = true;
    mutableTaps = true;
  };
}