{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./luks.nix
    ./network.nix
    ./kmonad.nix
    ./touchscreen.nix
  ];
  hardware.microsoft-surface.kernelVersion = "stable";
  boot.kernelPatches = [{
    name = "./linux-6.15.9-generate_rust_target_rs.patch";
    patch = ./linux-6.15.9-generate_rust_target_rs.patch;
  }];
}
