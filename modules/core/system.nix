{ host, ... }:
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
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  # Локализация и часовой пояс
  time.timeZone = "Europe/Moscow";

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
    LANG = "ru_RU.UTF-8";           # Основной язык системы
    LC_ADDRESS = "ru_RU.UTF-8";     # Формат адресов

    # en_US
    LC_CTYPE = "en_US.UTF-8";       # Классификация символов (регистр, типы символов)
    LC_NUMERIC = "en_US.UTF-8";     # Формат чисел (разделители, десятичные точки)
    LC_MESSAGES = "en_US.UTF-8";    # Язык системных сообщений и диалогов
  };

  # Переменные окружения
  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };

  # Консольная раскладка
  console.keyMap = "us";
}
