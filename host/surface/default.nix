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
}
