{ config, lib, pkgs, ... }: {
  disabledModules = [
    "profiles/base.nix"
  ];
  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  # boot.loader.grub.enable = false;

  # Enables the generation of /boot/extlinux/extlinux.conf
  # boot.loader.generic-extlinux-compatible.enable = true;

  # # this is deprecated. whats the replacement ?
  # boot.loader.raspberryPi.firmwareConfig = '' dtparam=audio=on '';
  # boot.loader.raspberryPi.uboot.enable = true;
  # boot.loader.raspberryPi.enable = true;
  # boot.loader.raspberryPi.version = 3;
  # TODO
  # dt* configs.txt seems to not apply ?
  # find working config.txt (with hifiberry) from vanilla raspbian
  # see if vcgencmd shows the dt* configs on raspbian
  boot.kernelParams = [ "snd_bcm2835.enable_hdmi=1" ];
  security.sudo.wheelNeedsPassword = false;
  networking.firewall.enable = false;

  # OOM configuration:
  systemd = {
    # Create a separate slice for nix-daemon that is
    # memory-managed by the userspace systemd-oomd killer
    slices."nix-daemon".sliceConfig = {
      ManagedOOMMemoryPressure = "kill";
      ManagedOOMMemoryPressureLimit = "70%";
    };
    services."nix-daemon".serviceConfig.Slice = "nix-daemon.slice";

    # If a kernel-level OOM event does occur anyway,
    # strongly prefer killing nix-daemon child processes
    services."nix-daemon".serviceConfig.OOMScoreAdjust = 1000;
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    pciutils
  ];
}
