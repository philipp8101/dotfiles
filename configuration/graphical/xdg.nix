{ config, pkgs, lib, ... }:
let
portals = [
  { option = config.services.desktopManager.plasma6.enable; portal = pkgs.kdePackages.xdg-desktop-portal-kde; }
  { option = config.programs.hyprland.enable; portal = pkgs.xdg-desktop-portal-hyprland; }
];
in {
  xdg.portal = {
    enable = lib.fold (lib.or) false (map (x: x.option) portals);
    extraPortals = lib.concatMap ({option,portal}: lib.optional option portal) portals;
  };
}
