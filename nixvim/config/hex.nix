{ pkgs, ... }:
{
  plugins.hex.enable = true;
  extraPackages = [ pkgs.xxd ];
}
