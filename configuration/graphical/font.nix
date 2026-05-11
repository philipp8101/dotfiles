{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    inconsolata
    nerd-fonts.inconsolata
  ];
}
