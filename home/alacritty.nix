{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors.bright = {
        black    =  "0x565656";
        blue     =  "0x49a4f8";
        cyan     =  "0x99faf2";
        green    =  "0xc0e17d";
        magenta  =  "0xa47de9";
        red      =  "0xec5357";
        white    =  "0xffffff";
        yellow   =  "0xf9da6a";
      };
      colors.normal = {
        black    =  "0x2e2e2e";
        blue     =  "0x47a0f3";
        cyan     =  "0x64dbed";
        green    =  "0xabe047";
        magenta  =  "0x7b5cb0";
        red      =  "0xeb4129";
        white    =  "0xe5e9f0";
        yellow   =  "0xf6c744";
      };
      colors.primary = {
        background = "0x000000";
        foreground = "0xfffbf6";
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
