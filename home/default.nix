{ config, pkgs, inputs, user, self, system, lib, ... }:
{
  options = {
    gui = lib.mkOption {
      type = lib.types.bool;
      default = config.xsession.windowManager.i3.enable || config.wayland.windowManager.hyprland.enable;
      description = "enable general gui related configurations (e.g. styling, cursor, fonts) and programs (e.g. terminal)";
    };
  };
  config = {
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";
    home.stateVersion = "23.11"; # Please read the comment before changing.


    programs.home-manager.enable = true;
  };
  imports = [
    ./hyprland
    ./i3
    ./misc
    ./programs
  ];
}
