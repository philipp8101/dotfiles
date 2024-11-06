{ pkgs, config, ... }:
{
  programs.hyprlock = {
    enable = config.wayland.windowManager.hyprland.enable;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = builtins.map
        (m: {
          monitor = m;
          path = "/tmp/${m}.png";
          blur_passes = 3;
          blur_size = 8;
        }) (map (x: x.identifier) config.displays);
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "${config.primaryDisplay.identifier}";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(${config.colorScheme.palette.base05})";
          inner_color = "rgb(${config.colorScheme.palette.base00})";
          outer_color = "rgb(${config.colorScheme.palette.base02})";
          outline_thickness = 5;
          placeholder_text = ''<span foreground="##${config.colorScheme.palette.base05}">Password...</span>'';
          shadow_passes = 2;
        }
      ];
    };
  };
}
