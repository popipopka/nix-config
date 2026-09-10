{ pkgs, lib, ... }:
{
  git-hooks.hooks = {
    gitleaks = {
      enable = lib.mkDefault true;
      name = "Detect hardcoded secrets";
      entry = "${pkgs.gitleaks}/bin/gitleaks git --pre-commit --redact --staged";
      pass_filenames = false;
      stages = [ "pre-commit" ];
    };
    detect-private-keys.enable = lib.mkDefault true;
  };
}
