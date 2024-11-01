{ pkgs, config, ... }:
let
  save-screenshots = import ./save-screenshots.nix { inherit pkgs; };
in
{
  services.hypridle = {
    enable = config.wayland.windowManager.hyprland.enable;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "loginctl lock-session";
        ignore_dbus_inhibit = false;
        lock_cmd = "${save-screenshots}/bin/save-screenshots ; ${pkgs.hyprlock}/bin/hyprlock";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${save-screenshots}/bin/save-screenshots ; ${pkgs.hyprlock}/bin/hyprlock";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
