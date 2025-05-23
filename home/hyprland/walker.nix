{ config, pkgs, inputs, ... }:
{
  programs.walker = {
    enable = config.wayland.windowManager.hyprland.enable;
    runAsService = true;
  };
  home.packages = [ pkgs.libqalculate ];
  imports = [
    inputs.walker.homeManagerModules.default
  ];
}
