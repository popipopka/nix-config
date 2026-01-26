{pkgs, upkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # Код
      (upkgs.yaak)
      (upkgs.jetbrains.idea)
      (upkgs.android-studio)
      (upkgs.gemini-cli-bin)
    ];
  };
}