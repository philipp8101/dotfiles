{ pkgs, ... }:
{
  config.wayland.windowManager.hyprland = {
    plugins = with pkgs.hyprlandPlugins; [ hyprwinwrap ];
    settings.plugin.hyprwinwrap.title = [ "gifview" ];
  };
}
