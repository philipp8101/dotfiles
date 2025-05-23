{ pkgs, config, lib, ... }:
{
  fonts.fontconfig.enable = config.gui;
  home.packages = lib.mkIf config.gui (with pkgs; [
    inconsolata
    nerd-fonts.inconsolata
  ]);
}
