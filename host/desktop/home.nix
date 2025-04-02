let
in
{
  displays = [
    {
      identifier = "DP-1";
    }
    {
      identifier = "DP-2";
      isPrimary = true;
      offset = "1920x0";
      refreshrate = 144.0;
    }
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    layout = "dwindle";
  };
}
