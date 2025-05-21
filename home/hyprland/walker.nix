{ config, pkgs, ... }:
{
  programs.walker = {
    enable = config.wayland.windowManager.hyprland.enable;
    runAsService = true;
  };
  home.packages = [ pkgs.libqalculate ];
}
