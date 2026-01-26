{
  services = {
    ollama = {
      enable = true;

      openFirewall = true;
      host = "0.0.0.0";

      acceleration = "cuda";
      loadModels = [
        "aliafshar/gemma3-it-qat-tools:12b"
      ];
    };
  };
}