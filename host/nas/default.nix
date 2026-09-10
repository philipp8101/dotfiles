{ lib, modulesPath, ... }:
{
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.systemd-boot.enable = lib.mkForce false;

  imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      ./sops.nix
      ./network.nix
    ];

  boot.initrd.availableKernelModules = [ "ahci" "nvme" "sdhci_of_dwcmshc" "dw_mmc_rockchip" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
      fsType = "ext4";
    };
  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
