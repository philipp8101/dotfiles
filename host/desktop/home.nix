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
    {
      identifier = "HDMI-A-1";
      offset = "3840x0";
    }
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    layout = "dwindle";
  };
}
