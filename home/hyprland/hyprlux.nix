{
  programs.hyprlux = {
    enable = true;

    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    night_light = {
      enabled = true;
      latitude = 51.0;
      longitude = 12.0;
      temperature = 4500;
    };

  };
}
