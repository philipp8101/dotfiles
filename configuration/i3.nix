{ pkgs, ... }:
{
	services.xserver = {
		enable = true;
		resolutions = [
		{ x = 1920; y = 1080; }
		];
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu
					i3status
					i3lock
					i3blocks
					polybarFull
					dunst
					rofi
			];
		};
	};
}
