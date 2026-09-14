{ pkgs, ... }:
let
  layoutPath = builtins.path {
    path = ./keymap.xkb;
    name = "custom-xkb-layout";
  };
  compiledLayout = pkgs.runCommand "keyboard-layout" { } "${pkgs.xkbcomp}/bin/xkbcomp ${layoutPath} $out";
in
{
  home.shellAliases = {
    "workman" = "${pkgs.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
  };
}
