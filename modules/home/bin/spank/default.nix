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
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };

        vendorHash = null;
      })
  ];
}
