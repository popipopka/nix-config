{ lib, ... }:
{
  git-hooks.hooks = {
    check-merge-conflicts.enable = lib.mkDefault true;
    check-added-large-files.enable = lib.mkDefault true;
    check-yaml.enable = lib.mkDefault true;
    check-json.enable = lib.mkDefault true;
    check-toml.enable = lib.mkDefault true;
    check-case-conflicts.enable = lib.mkDefault true;
    check-symlinks.enable = lib.mkDefault true;
    trim-trailing-whitespace.enable = lib.mkDefault true;
    end-of-file-fixer.enable = lib.mkDefault true;
    mixed-line-endings.enable = lib.mkDefault true;
  };
}
