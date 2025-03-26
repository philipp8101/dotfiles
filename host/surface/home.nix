let
in
{
  displays = [
    {
      identifier = "eDP-1";
      isPrimary = true;
      resolution = "2736x1824";
      refreshrate = 59.96;
      scale = 2;
    }
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    layout = "dwindle";
  };
}
