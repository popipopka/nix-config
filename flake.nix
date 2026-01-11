{
  description = "Помогите...";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    stylix.url = "github:danth/stylix/release-25.11";

    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "nix";
      username = "belykh";
      profile = "vm";

      mkNixosConfig = gpuProfile:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit host;
            inherit profile;
          };
          modules = [
            ./profiles/${gpuProfile}
          ];
        };

    in {
      nixosConfigurations = {
        amd = mkNixosConfig "amd";
        nvidia = mkNixosConfig "nvidia";
        intel = mkNixosConfig "intel";
        vm = mkNixosConfig "vm";
      };

      formatter.x86_64-linux = inputs.alejandra.packages.x86_64-linux.default;
    };
}
