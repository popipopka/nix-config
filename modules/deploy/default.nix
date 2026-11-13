{ lib, settings, ... }:
{
  imports = []
    ++ lib.optional settings.singbox.enabled ./singbox;
}
