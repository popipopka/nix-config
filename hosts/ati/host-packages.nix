{pkgs, upkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # Код
      (upkgs.yaak)
    ];
  };
}