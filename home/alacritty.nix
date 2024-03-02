{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors.bright = {
        black = "0x${config.colorScheme.colors.base01}";
        blue = "0x${config.colorScheme.colors.base0D}";
        cyan = "0x${config.colorScheme.colors.base0C}";
        green = "0x${config.colorScheme.colors.base0B}";
        magenta = "0x${config.colorScheme.colors.base0E}";
        red = "0x${config.colorScheme.colors.base08}";
        white = "0x${config.colorScheme.colors.base05}";
        yellow = "0x${config.colorScheme.colors.base0A}";
      };
      colors.normal = {
        black = "0x${config.colorScheme.colors.base01}";
        blue = "0x${config.colorScheme.colors.base0D}";
        cyan = "0x${config.colorScheme.colors.base0C}";
        green = "0x${config.colorScheme.colors.base0B}";
        magenta = "0x${config.colorScheme.colors.base0E}";
        red = "0x${config.colorScheme.colors.base08}";
        white = "0x${config.colorScheme.colors.base05}";
        yellow = "0x${config.colorScheme.colors.base0A}";
      };
      colors.primary = {
        background = "0x${config.colorScheme.colors.base00}";
        foreground = "0x${config.colorScheme.colors.base05}";
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
