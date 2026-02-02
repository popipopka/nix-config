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
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      username = "belykh";
      macbook = "Egors-Macbook-Pro";
    in {
      darwinConfigurations.${macbook} = nix-darwin.lib.darwinSystem {
        modules = [
          ./variables.nix
          /modules/core
        ];
      };
    };
}
