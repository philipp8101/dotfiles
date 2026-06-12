{ pkgs, user, lib, inputs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = builtins.concatMap (arch: (lib.optional (pkgs.stdenv.hostPlatform.system != arch) arch)) [
      "aarch64-linux"
    ];
    loader.systemd-boot.configurationLimit = 5;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
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
  services.xserver.xkb.layout = "de";


  security.rtkit.enable = true;
  users.users.${user} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "${user}";
    # group = "${user}";
    extraGroups = [
      "wheel"
      "dialout"
      "adbusers"
    ];
  };

  programs.zsh.enable = true;

  environment = {
    pathsToLink = [ "/libexec" ];
  };

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  boot.kernel.sysctl."kernel.sysrq" = 502;

}
