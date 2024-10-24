{ pkgs, config, ... }:
{
	programs.hyprland = {
		xwayland.enable = true;
	};
	xdg.portal = {
		enable = config.programs.hyprland.enable;
		extraPortals = with pkgs; [
			(pkgs.lib.mkIf config.services.desktopManager.plasma6.enable xdg-desktop-portal-hyprland)
		];
	};
	services.displayManager.defaultSession = pkgs.lib.mkIf config.programs.hyprland.enable "hyprland";
}
