{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) timeZone;
in
{
  system.stateVersion = "23.11"; # Do not change!

  # Глобальная настройки Nix
  nix = {
    settings = {
      download-buffer-size = 200000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Локализация и часовой пояс
  time.timeZone = timeZone;

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    # ru_RU
    LC_TIME = "ru_RU.UTF-8";        # Формат даты и времени
    LC_MONETARY = "ru_RU.UTF-8";    # Формат денежных единиц
    LC_PAPER = "ru_RU.UTF-8";       # Формат бумаги
    LC_MEASUREMENT = "ru_RU.UTF-8"; # Метрическая система измерений
    LC_TELEPHONE = "ru_RU.UTF-8";   # Формат телефонных номеров
    LC_ADDRESS = "ru_RU.UTF-8";     # Формат адресов
  };

  # Консольная раскладка
  console.keyMap = "us";
}
