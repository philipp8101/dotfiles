{ config, ... }:
{
  services.syncthing.enable = config.gui;
}
