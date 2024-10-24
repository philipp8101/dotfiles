{ pkgs, inputs, system, config, ... }:
{
  services.hyprpaper = {
    enable = config.wayland.windowManager.hyprland.enable;
    package = inputs.hyprpaper-custom.packages.${system}.default;
    settings = {
      preload-random = "/tank/home/Pictures/wallpaper/wallpaper-guweiz/dark/, pic1, pic2, pic3";
      wallpaper = [
        "DP-1, pic1"
        "DP-2, pic2"
        "HDMI-A-1, pic3"
      ];
    };
  };
}
