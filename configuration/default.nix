{ config, pkgs, inputs, self, user, ... }:
{
  imports = [
    ./i3.nix
    ./plasma.nix
    ./hyprland.nix
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
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
  };
  networking = {
    hostId = "e52e59bb";
    hostName = "desktop";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        1883 # mqtt
      ];
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
    graphics.enable = true;
    graphics.enable32Bit = true; # https://nixos.wiki/wiki/Lutris
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      # package = config.boot.kernelPackages.nvidiaPackages.production;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.42.02";
        sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
        sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        persistencedSha256 = pkgs.lib.fakeSha256;
      };
    };
    i2c.enable = true; # for ddcutil
  };
  security.rtkit.enable = true;
  users.users.${user} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "${user}";
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
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
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
      lutris
      nix-index
      htop-vim
      obsidian
      wl-clipboard
      vesktop
      tidal-hifi
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      self.outputs.packages.${system}.nixvim
      adwaita-icon-theme
      dolphin
      libsForQt5.kde-cli-tools
      kdePackages.breeze
      kdePackages.breeze-icons
      kdePackages.qtwayland
      kdePackages.qtsvg
      kdePackages.kio-fuse
      kdePackages.kio-extras
      kdePackages.kdesdk-thumbnailers
      kdePackages.kdegraphics-thumbnailers
      kdePackages.ffmpegthumbs
      okular
      gwenview
      ark
      libsForQt5.qt5.qtgraphicaleffects
    ];
    pathsToLink = [ "/libexec" ];
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
    displayManager.sddm = {
      enable = true;
      theme = "Elegant";
      settings.Theme.ThemeDir = "${pkgs.elegant-sddm.override {
         themeConfig.General = {
           background = "${builtins.fetchurl {
             url = "https://raw.githubusercontent.com/JaKooLit/Wallpaper-Bank/a0f287a72a04eac7acdaabcaf1a9ecfbdcea1eb8/wallpapers/Anime-City-Night.png";
             sha256 = "sha256:1yv1ckg95614mcldkwznvbxdylrjfmsahdf6c9fp2zk339vs34z1";
           }}";
         };
      }}/share/sddm/themes";
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
    xserver.videoDrivers = [ "nvidia" ];
    xserver.xkb.layout = "de";
    mosquitto = {
      enable = true;
      listeners = [{
        acl = [ "pattern readwrite #" ];
        port = 1883;
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }];
    };
    ddccontrol.enable = true;
  };
  fonts.packages = with pkgs; [
    inconsolata
    inconsolata-nerdfont
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";

  virtualisation.docker.enable = true;

}
