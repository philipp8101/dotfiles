{ config, pkgs, inputs, self, ... }:
let 
layoutPath = builtins.path {
	path = ./keymap.xkb;
	name = "custom-xkb-layout";
};
compiledLayout = pkgs.runCommand "keyboard-layout" {} "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${layoutPath} $out";
in
{
	imports = [
		./hardware-configuration.nix
	];
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		supportedFilesystems = [ "zfs" ];
		zfs = {
			forceImportRoot = false;
			extraPools = [ ];
		};
		# kernelPackages = pkgs.linuxPackages_6_9;
		binfmt.emulatedSystems = [ "aarch64-linux" ];
	};
	networking = {
		hostId = "e52e59bb";
		hostName = "nixos";
		networkmanager.enable = true;
		firewall = {
			enable = true;
			allowedTCPPorts = [ 1883 ];
		};
	};
	services.udev = {
		enable = true;
		extraRules = ''
		KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12c2", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
		'';
	};
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
	hardware = {
		pulseaudio.enable = false;
		opengl.enable = true;
		opengl.driSupport32Bit = true; # https://nixos.wiki/wiki/Lutris
		nvidia = {
			modesetting.enable = true;
			open = false;
			nvidiaSettings = true;
			powerManagement.enable = true;
			# package = config.boot.kernelPackages.nvidiaPackages.production;
		};
	};
	security.rtkit.enable = true;
	users.users.philipp = {
		shell = pkgs.zsh;
		isNormalUser = true;
		description = "philipp";
		extraGroups = [ "networkmanager" "wheel" "docker" "dialout" ];
	};
	services.openssh.enable = true;
	programs = {
		zsh.enable = true;
		ssh.startAgent = true;
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
		};
		hyprland = {
			enable = true;
			xwayland.enable = true;
		};
	};

	nixpkgs.config.allowUnfree = true;

	environment = {
		sessionVariables = {
			SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
		};
		shellAliases = {
			"workman" =  "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
		};
		systemPackages = with pkgs; [
			wget
			tmux
			kitty
			polkit
			dconf
			xwayland
			gcc
			unzip
			fzf
			home-manager
			ripgrep
			firefox
			xsel
			gnome.eog
			evince
			gnome.adwaita-icon-theme
			lutris
			nix-index
			htop-vim
			obsidian
			wl-clipboard
			spotify
			vesktop
			tidal-hifi
			libsForQt5.qtstyleplugin-kvantum
			libsForQt5.qt5ct
			self.outputs.nixvim
			kdePackages.dolphin
			kdePackages.gwenview
			kdePackages.okular
		];
		pathsToLink = ["/libexec"];
	};
	# environment.plasma6.excludePackages = with pkgs.kdePackages; [
	# 	plasma-browser-integration
	# 	oxygen
	# ];
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-hyprland
			# xdg-desktop-portal-wlr
			# xdg-desktop-portal-kde
			# xdg-desktop-portal-gtk
		];
	};
	services = {
		printing.enable = true;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};
		displayManager.sddm.wayland.enable = true;
		displayManager.sddm.enable = true;
		desktopManager.plasma6.enable = true;
		displayManager.defaultSession = "hyprland";
		xserver.videoDrivers = [ "nvidia" ];

		xserver = {
			enable = true;
			xkb.layout = "de";
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
		mosquitto = {
			enable = true;
			listeners = [{
				acl = [ "pattern readwrite #" ];
				port = 1883;
				omitPasswordAuth = true;
				settings.allow_anonymous = true;
			}];
		};
	};
	fonts.packages = with pkgs; [
		inconsolata
		inconsolata-nerdfont
	];
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	system.stateVersion = "23.11";

	virtualisation.docker.enable = true;

}
