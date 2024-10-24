{ pkgs, ... }:
pkgs.writeShellScriptBin "save-screenshots" ''
  for i in $(hyprctl monitors -j |${pkgs.jq}/bin/jq -r '.[].name') ; do
    ${pkgs.grim}/bin/grim -o $i "/tmp/$i.png" ; 
  done
  exit 0;
''
