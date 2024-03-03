{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors.bright = {
        black = "0x${config.colorScheme.palette.base01}";
        blue = "0x${config.colorScheme.palette.base0D}";
        cyan = "0x${config.colorScheme.palette.base0C}";
        green = "0x${config.colorScheme.palette.base0B}";
        magenta = "0x${config.colorScheme.palette.base0E}";
        red = "0x${config.colorScheme.palette.base08}";
        white = "0x${config.colorScheme.palette.base05}";
        yellow = "0x${config.colorScheme.palette.base0A}";
      };
      colors.normal = {
        black = "0x${config.colorScheme.palette.base01}";
        blue = "0x${config.colorScheme.palette.base0D}";
        cyan = "0x${config.colorScheme.palette.base0C}";
        green = "0x${config.colorScheme.palette.base0B}";
        magenta = "0x${config.colorScheme.palette.base0E}";
        red = "0x${config.colorScheme.palette.base08}";
        white = "0x${config.colorScheme.palette.base05}";
        yellow = "0x${config.colorScheme.palette.base0A}";
      };
      colors.primary = {
        background = "0x${config.colorScheme.palette.base00}";
        foreground = "0x${config.colorScheme.palette.base05}";
      };
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 14.0;
      };
      font.bold = {
        family = "Inconsolata";
        style = "Bold";
      };
      font.bold_italic = {
        family = "Inconsolata";
        style = "Bold Italic";
      };
      font.italic = {
        family = "Inconsolata";
        style = "Italic";
      };
      font.normal = {
        family = "Inconsolata";
        style = "Regular";
      };
      window = {
        opacity = 0.8;
        startup_mode = "Windowed";
      };
      window.dimensions = {
        columns = 0;
        lines = 0;
      };
    };
  };
}
