{ pkgs, ... }:
{
	services = {
		desktopManager.plasma6.enable = true;
		displayManager.defaultSession = "plasma";
	};
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-kde
		];
	};
}
