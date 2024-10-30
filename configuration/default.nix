{ config, pkgs, inputs, self, user, ... }:
{
  imports = [
    ./hyprland.nix
    ./i3.nix
    ./packages.nix
    ./plasma.nix
    ./sddm.nix
    ./kmonad.nix
  ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
  };
  networking = {
    networkmanager.enable = true;
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
    i2c.enable = true; # for ddcutil
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };
  security.rtkit.enable = true;
  users.users.${user} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "docker" "dialout" ];
  };
  services.openssh.enable = true;
  services.tailscale.enable = true;
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
    xserver.xkb.layout = "de";
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
