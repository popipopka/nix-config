{
  description = "Помогите...";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    catppuccin.url = "github:catppuccin/nix";
#    stylix.url = "github:danth/stylix";
    quickshell = {
          url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
          inputs.nixpkgs.follows = "nixpkgs";
        };

  };

  outputs = { nixpkgs, home-manager, quickshell, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "nix";
      username = "belykh";
      profile = "vm";

    in {
      nixosConfigurations = {
        amd = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit host;
            inherit profile;
          };
          modules = [
            ./profiles/amd
#            stylix.nixosModules.stylix
          ];
        };

        nvidia = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit host;
            inherit profile;
          };
          modules = [
            ./profiles/nvidia
#            stylix.nixosModules.stylix
          ];
        };

        nvidia-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit host;
            inherit profile;
          };
          modules = [
            ./profiles/nvidia-laptop
#            stylix.nixosModules.stylix
          ];
        };

        intel = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit host;
            inherit profile;
          };
          modules = [
            ./profiles/intel
#            stylix.nixosModules.stylix
          ];
        };

        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit host;
            inherit profile;
          };
          modules = [
            ./profiles/vm
#            stylix.nixosModules.stylix
          ];
        };
      };
    };
}
