{
  config.wayland.windowManager.hyprland.settings = {
    general.layout = "dwindle";
    bind = [
      "$mod, D, changegroupactive, previous"
      "$mod SHIFT, D, togglegroup"
      "$mod, R, togglesplit, # dwindle"
      "$mod SHIFT, R, moveoutofgroup"
      "$mod, B, fullscreen, 1"
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod SHIFT, left, movewindow, l"
      "$mod SHIFT, right, movewindow, r"
      "$mod SHIFT, up, movewindow, u"
      "$mod SHIFT, down, movewindow, d"
    ];
  };
}
