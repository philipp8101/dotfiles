{ config, ... }:
{
  programs.kitty = {
    enable = config.gui;
    font = {
      name = "Inconsolata Nerd Font";
      size = 14;
    };
    settings = {
      background_opacity = "0.8";
      enable_audio_bell = false;
    };
    extraConfig = ''
    map ctrl+shift+p>f kitten hints --type path --program @
    '';
  };
}
