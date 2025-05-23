{ config, ... }:
{
  programs.mpv = {
    enable = config.gui;
    config = {
      save-position-on-quit = true;
    };
  };
}
