{ pkgs, config, ... }:
{
  services = {
    # desktopManager.plasma6.enable = true;
    # displayManager.defaultSession = pkgs.lib.mkIf config.services.desktopManager.plasma6.enable "plasma";
  };
}
