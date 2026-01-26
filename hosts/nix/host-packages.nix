{pkgs, upkgs, ...}: {
  environment = {
    #sessionVariables.PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    #sessionVariables.PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
    sessionVariables.CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
    
    systemPackages = with pkgs; [
      # Playwright
      #(upkgs.python312Packages.playwright)
      #(upkgs.playwright-driver.browsers)
      
      # Код
      (upkgs.jetbrains.pycharm)
      (upkgs.jetbrains.idea)
      (upkgs.android-studio)
      (upkgs.code-cursor)
      (upkgs.yaak)
      (upkgs.dbeaver-bin)
      (upkgs.gemini-cli-bin)
      
      # Офисный пакет
      libreoffice
      hunspell
      hunspellDicts.ru-ru
      hunspellDicts.en-us
      
      # Заметки
      obsidian
      (upkgs.affine)
    ];
  };
}