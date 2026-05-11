{ pkgs, ... }:
{
  locate.enable = true;
  locate.package = pkgs.plocate;
}
