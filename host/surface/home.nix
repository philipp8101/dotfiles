let
in
{
  displays = [
    {
      identifier = "eDP-1";
      isPrimary = true;
    }
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    layout = "scroller";
  };
}
