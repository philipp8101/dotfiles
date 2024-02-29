{ config, pkgs, ... }:
let 
layoutPath = builtins.path {
	path = ./.config/xkb/symbols/de;
	name = "custom-xkb-layout";
};
compiledLayout = pkgs.runCommand "keyboard-layout" {} "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${layoutPath} $out";
in
{
	imports = [
		./hardware-configuration.nix
	];
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	networking.hostName = "nixos";
	networking.networkmanager.enable = true;
	time.timeZone = "Europe/Berlin";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "de_DE.UTF-8";
		LC_IDENTIFICATION = "de_DE.UTF-8";
		LC_MEASUREMENT = "de_DE.UTF-8";
		LC_MONETARY = "de_DE.UTF-8";
		LC_NAME = "de_DE.UTF-8";
		LC_NUMERIC = "de_DE.UTF-8";
		LC_PAPER = "de_DE.UTF-8";
		LC_TELEPHONE = "de_DE.UTF-8";
		LC_TIME = "de_DE.UTF-8";
	};


	console.keyMap = "de";
	services.printing.enable = true;
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};
	users.users.philipp = {
		shell = pkgs.zsh;
		isNormalUser = true;
		description = "philipp";
		extraGroups = [ "networkmanager" "wheel" ];
	};
	programs.zsh.enable = true;

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		neovim
		wget
		tmux
		kitty
		polkit
		xdg-desktop-portal-hyprland
		dconf
		xwayland
		gcc
		unzip
		fzf
		home-manager
		ripgrep
		firefox
	];
	environment.pathsToLink = ["/libexec"];
	services.xserver = {
		enable = true;
		layout = "de";
		resolutions = [
			{ x = 1920; y = 1080; }
		];
		desktopManager = {
			xterm.enable = false;
		};
		displayManager = {
			defaultSession = "none+i3";
			sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
		};
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
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
	fonts.packages = with pkgs; [
		inconsolata
		inconsolata-nerdfont
	];
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	system.stateVersion = "23.11";

}