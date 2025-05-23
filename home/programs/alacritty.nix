{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = config.gui;
    settings = {
      colors.bright = {
        black = "0x${config.colorScheme.palette.base04}";
        blue = "0x${config.colorScheme.palette.base0D}";
        cyan = "0x${config.colorScheme.palette.base0E}";
        green = "0x${config.colorScheme.palette.base0B}";
        magenta = "0x${config.colorScheme.palette.base09}";
        red = "0x${config.colorScheme.palette.base08}";
        white = "0x${config.colorScheme.palette.base0F}";
        yellow = "0x${config.colorScheme.palette.base0A}";
      };
      colors.normal = {
        black = "0x${config.colorScheme.palette.base04}";
        blue = "0x${config.colorScheme.palette.base0D}";
        cyan = "0x${config.colorScheme.palette.base0E}";
        green = "0x${config.colorScheme.palette.base0B}";
        magenta = "0x${config.colorScheme.palette.base09}";
        red = "0x${config.colorScheme.palette.base08}";
        white = "0x${config.colorScheme.palette.base0F}";
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
        family = "Inconsolata Nerd Font";
        style = "Bold";
      };
      font.bold_italic = {
        family = "Inconsolata Nerd Font";
        style = "Bold Italic";
      };
      font.italic = {
        family = "Inconsolata Nerd Font";
        style = "Italic";
      };
      font.normal = {
        family = "Inconsolata Nerd Font";
        style = "Regular";
      };
      window = {
        opacity = 1;
        startup_mode = "Windowed";
      };
      window.dimensions = {
        columns = 0;
        lines = 0;
      };
    };
  };
}
