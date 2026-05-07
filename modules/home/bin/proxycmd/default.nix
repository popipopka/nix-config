{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writers.writePython3Bin "proxycmd"
      { flakeIgnore = [ "E501" ]; }
      (builtins.readFile ./proxycmd.py))
  ];

  home.shellAliases = {
    pc = "proxycmd";
  };
}
