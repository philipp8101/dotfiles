{ pkgs, ... }:
{
  config.wayland.windowManager.hyprland = {
    plugins = with pkgs.hyprlandPlugins; [
      hyprscrolling
    ];
    settings = {
      plugin.scrolling = {
        column_width = 0.5;
        fullscreen_on_one_column = true;
        focus_fit_method = 1;
        # explicit_column_widths = "\"0.5, 1.0\"";
      };
      general.layout = "scrolling";
      bind = [
        # "$mod, D, scroller:admitwindow"
        # "$mod, R, scroller:expelwindow"
        # "$mod, left, layoutmsg, move -col"
        # "$mod, right, layoutmsg, move +col"
        "$mod, left, layoutmsg, focus l"
        "$mod, right, layoutmsg, focus r"
        "$mod, up, layoutmsg, focus u"
        "$mod, down, layoutmsg, focus d"
        "$mod, B, layoutmsg, colresize +0.5"
        "$mod SHIFT, left, layoutmsg, movewindowto l"
        "$mod SHIFT, right, layoutmsg, movewindowto r"
        "$mod SHIFT, up, layoutmsg, movewindowto u"
        "$mod SHIFT, down, layoutmsg, movewindowto d"
      ];
    };
  };
}
