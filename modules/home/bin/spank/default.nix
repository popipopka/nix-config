{ pkgs, ... }:
{
  home.packages = [
    (pkgs.buildGoModule rec {
        pname = "spank";
        version = "1.2.5";

        src = pkgs.fetchFromGitHub {
          owner = "taigrr";
          repo = "spank";
          rev = "v${version}";
          sha256 = "sha256-IjliPbxCrjYsGDZMaG+5DD01xkGPf01V4eYU/CM8dDs=";
        };

        vendorHash = "sha256-R63lSTQvwZ/zw2ccuwXk6rkuQ0t2Zs4mU3Trh+IxKf4=";
        doCheck = false;
      })
  ];
}
