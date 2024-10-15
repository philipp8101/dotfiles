{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#${config.colorScheme.palette.base04}";
        separator_color = "frame";
        offset = "20x50";
        origin = "top-right";
      };
      urgency_low = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
        frame_color = "#${config.colorScheme.palette.base03}";
      };
      urgency_normal = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
      };
      urgency_critical = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base0F}";
        frame_color = "#${config.colorScheme.palette.base08}";
      };
    };
  };
}
