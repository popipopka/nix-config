{
  description = "Бог помог.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, ... }:
    let
      system = "aarch64-darwin";
      username = "belykh";
      macbook = "Egors-MacBook-Pro";
    in {
      darwinConfigurations.${macbook} = nix-darwin.lib.darwinSystem {
	      system = system;

        specialArgs = { inherit inputs system username; };

        modules = [
          inputs.determinate.darwinModules.default
          ./modules/core
        ];
      };
    };
}
