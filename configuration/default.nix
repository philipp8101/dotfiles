{ pkgs, user, lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./i3.nix
    ./packages.nix
    ./plasma.nix
    ./sddm.nix
    ./xdg.nix
    ./audio.nix
  ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = lib.mkIf (pkgs.stdenv.hostPlatform.system != "aarch64-linux") [ "aarch64-linux" ];
    loader.systemd-boot.configurationLimit = 5;
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
  };
  networking = {
    networkmanager.enable = true;
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
    i2c.enable = true; # for ddcutil
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };
  security.rtkit.enable = true;
  users.users.${user} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "${user}";
    # group = "${user}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "dialout"
      "wireshark"
      "video" # control screen brightness via brillo
      "adbusers"
    ];
  };
  # users.groups.${user} = {};
  hardware.brillo.enable = true;
  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
    adb.enable = true;
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
    pulseaudio.enable = false;
    openssh.enable = true;
    tailscale.enable = true;
    blueman.enable = true;
    locate.enable = true;
    locate.package = pkgs.plocate;
    xserver.xkb.layout = "de";
    ddccontrol.enable = true;
    udev = {
      enable = true;
      extraRules = builtins.concatStringsSep "\n" [
        # steelseries for headsetctl
        ''KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12c2", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"''
        # logic analyser
        ''SUBSYSTEM=="usb", ATTR{idVendor}=="0925", ATTR{idProduct}=="3881", MODE="0666", GROUP="plugdev"''
      ];
    };
  };
  fonts.packages = with pkgs; [
    inconsolata
    nerd-fonts.inconsolata
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "@wheel" ];

  system.stateVersion = "23.11";

  virtualisation.docker.enable = true;

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  documentation.enable = true;
  documentation.man.enable = true;
  documentation.doc.enable = true;
}
