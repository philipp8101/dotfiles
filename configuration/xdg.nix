{ config, pkgs, lib, ... }:
{
  xdg.portal = {
    enable = config.services.desktopManager.plasma6.enable || config.programs.hyprland.enable;
    extraPortals = (lib.optional config.services.desktopManager.plasma6.enable pkgs.kdePackages.xdg-desktop-portal-kde) 
                ++ (lib.optional config.programs.hyprland.enable pkgs.xdg-desktop-portal-hyprland);
    
  };
}
