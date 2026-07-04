{ username, lib, ... }:
{
  system = {
    primaryUser = "${username}";
    stateVersion = 5;
  };
}