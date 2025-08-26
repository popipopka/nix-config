{
  description = "Помогите...";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    catppuccin.url = "github:catppuccin/nix";
    stylix.url = "github:danth/stylix/release-25.05";
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
          ];
        };
      };
    };
}
