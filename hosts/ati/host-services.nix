{
  services = {
    ollama = {
      enable = true;
      openFirewall = true;
      loadModels = [
        "aliafshar/gemma3-it-qat-tools:12b"
      ];
    };
  };
}