{ pkgs, config, ... }:
{
  home.packages = [ pkgs.devenv ];

  nix.nixPath = [
    "devenvModules=${config.home.homeDirectory}/nix-config/modules/home/devenv/modules"
  ];

  home.shellAliases = {
    de = "devenv";
    des = "devenv shell";
    deu = "devenv update";
    dei = ''
      sh -c '
        set -eu
        modules=$(nix-instantiate --find-file devenvModules)
        shared=$(dirname "$modules")/shared
        write_yaml() {
          while IFS= read -r line || [ -n "$line" ]; do
            printf "%s\n" "$line"
            if [ "$line" = "inputs:" ]; then
              printf "  devenvModules:\n    url: \"path:%s\"\n    flake: false\n" "$modules"
            fi
          done < "$shared/devenv.yaml"
        }
        if [ -e devenv.yaml ] || [ -L devenv.yaml ]; then
          echo "devenv.yaml already exists. Merge this configuration manually:" >&2
          write_yaml >&2
          exit 1
        fi
        if [ -e devenv.nix ] || [ -L devenv.nix ]; then
          echo "devenv.nix already exists; refusing to overwrite it." >&2
          exit 1
        fi
        test -f "$shared/devenv.yaml"
        devenv init "$@"
        (
          export LC_ALL=C
          printf "{ inputs, ... }:\n{\n  imports = [\n"
          for module in "$modules"/*.nix; do
            [ -f "$module" ] || continue
            printf "    # (inputs.devenvModules + \"/%s\")\n" "$(basename "$module")"
          done
          printf "  ];\n}\n"
        ) > devenv.nix
        write_yaml > devenv.yaml
      ' dei'';
  };
}
