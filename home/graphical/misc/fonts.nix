{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    inconsolata
    nerd-fonts.inconsolata
  ];
}
