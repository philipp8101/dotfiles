{ pkgs, config, ... }:
{
  services = {
    # desktopManager.plasma6.enable = true;
    displayManager.defaultSession = pkgs.lib.mkIf config.services.desktopManager.plasma6.enable "plasma";
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      (pkgs.lib.mkIf config.services.desktopManager.plasma6.enable xdg-desktop-portal-kde)
    ];
  };
}
