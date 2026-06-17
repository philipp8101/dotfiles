{
  config.wayland.windowManager.hyprland = {
    settings = {
      general.layout = "scrolling";
      bind = [
        "$mod, D, layoutmsg, promote"
        "$mod, R, layoutmsg, swapcol l"
        "$mod, W, layoutmsg, swapcol r"
      ];
    };
  };
}
