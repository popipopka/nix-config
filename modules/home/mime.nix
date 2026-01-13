
let
  # Определяем переменные для удобства
  fileManager = "nemo.desktop";
  archiver = "org.gnome.FileRoller.desktop";
  browser = "google-chrome.desktop"
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ fileManager ];

      "application/zip" = [ archiver ];
      "application/x-tar" = [ archiver ];
      "application/vnd.rar" = [ archiver ];

      "text/html" = [ browser ];
      "x-scheme-handler/http" = [ browser ];
      "x-scheme-handler/https" = [ browser ];
    };
  };
}