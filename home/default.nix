{ config, pkgs, inputs, user, self, system, ... }:
{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./hyprland
    ./i3
    ./misc
    ./programs
    inputs.walker.homeManagerModules.default
  ];

  programs.home-manager.enable = true;
}
