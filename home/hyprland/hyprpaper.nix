{ pkgs, inputs, system, config, ... }:
let
inherit (pkgs.lib) length foldr zipListsWith range;
concat = foldr (a: b: a + b) "";
r = range 1 (length config.displays);
in 
{
  services.hyprpaper = {
    enable = config.wayland.windowManager.hyprland.enable;
    package = inputs.hyprpaper-custom.packages.${system}.default;
    settings = {
      preload-random = "~/Pictures/wallpaper/${concat (map (i: ", pic${toString i}") r)}";
      wallpaper = zipListsWith (i: x: "${x.identifier}, pic${toString i}") r config.displays;
    };
  };
}
