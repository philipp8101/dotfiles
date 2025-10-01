{ pkgs, ... }:
{
  config.wayland.windowManager.hyprland = {
    plugins = with pkgs.hyprlandPlugins; [
      hyprscroller
    ];
    settings = {
      plugin.scroller = {
        focus_wrap = "false";
        column_widths = "onehalf one";
      };
      general.layout = "scroller";
      bind = [
        "$mod, D, scroller:admitwindow"
        "$mod, R, scroller:expelwindow"
        "$mod, W, scroller:setmode, r"
        "$mod SHIFT, W, scroller:setmode, c"
        "$mod, B, scroller:cyclesize, next"
        "$mod, left, scroller:movefocus, l"
        "$mod, right, scroller:movefocus, r"
        "$mod, up, scroller:movefocus, u"
        "$mod, down, scroller:movefocus, d"
        "$mod SHIFT, left, scroller:movewindow, l"
        "$mod SHIFT, right, scroller:movewindow, r"
        "$mod SHIFT, up, scroller:movewindow, u"
        "$mod SHIFT, down, scroller:movewindow, d"
      ];
    };
  };
}
