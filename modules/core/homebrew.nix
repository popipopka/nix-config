{ username, inputs, ... }: {
#  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

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
      "dive"
    ];
    casks = [
      "orbstack"
    ];
  };

#  nix-homebrew = {
#    enable = false;
#    user = "${username}";
#
#    enableRosetta = true;
#    autoMigrate = true;
#    mutableTaps = true;
#  };
}