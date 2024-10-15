{ pkgs, ... }:
let 
layoutPath = builtins.path {
	path = ./keymap.xkb;
	name = "custom-xkb-layout";
};
compiledLayout = pkgs.runCommand "keyboard-layout" {} "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${layoutPath} $out";
in
{
    home.shellAliases = {
        "workman" =  "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
    };
}
