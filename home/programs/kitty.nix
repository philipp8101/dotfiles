{ config, ... }:
{
  programs.kitty = {
    enable = true;
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
  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "kitty.desktop" ];
  };
  qt.kde.settings.kdeglobals.General.TerminalApplication = "kitty";
  qt.kde.settings.kdeglobals.General.TerminalService = "kitty.service";
}
