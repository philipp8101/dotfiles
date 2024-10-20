{ pkgs, config, ... }:
{
  imports = [
    ./nix-colors.nix
  ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#${config.colorScheme.palette.base02}";
        separator_color = "frame";
        offset = "20x20";
        origin = "top-right";
        corner_radius = "10";
      };
      urgency_low = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
        frame_color = "#${config.colorScheme.palette.base02}";
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
