{ lib, settings, ... }:
{
  imports = []
    ++ lib.optional settings.singbox.enabled ./singbox
    ++ lib.optional settings.vkTurnProxy.enabled ./vk-turn-proxy;
}
