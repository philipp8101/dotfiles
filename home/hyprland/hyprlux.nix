{ config, ... }:
{
  programs.hyprlux = {
    enable = config.wayland.windowManager.hyprland.enable;

    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    night_light = {
      enabled = true;
      latitude = 51.0;
      longitude = 12.0;
      temperature = 4500;
    };

  };
}
