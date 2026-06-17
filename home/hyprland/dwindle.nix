{
  config.wayland.windowManager.hyprland.settings = {
    general.layout = "dwindle";
    bind = [
      "$mod, D, changegroupactive, previous"
      "$mod SHIFT, D, togglegroup"
      "$mod, R, layoutmsg, togglesplit # dwindle"
      "$mod SHIFT, R, moveoutofgroup"
    ];
  };
}
