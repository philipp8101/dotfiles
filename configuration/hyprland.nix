{ pkgs, config, ... }:
{
  programs.hyprland = {
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = config.programs.hyprland.enable;
    extraPortals = with pkgs; [
      (pkgs.lib.mkIf config.services.desktopManager.plasma6.enable xdg-desktop-portal-hyprland)
    ];
  };
  services.displayManager.defaultSession = pkgs.lib.mkIf config.programs.hyprland.enable "hyprland";
  systemd.user.services.sway-audio-idle-inhibit = {
    enable = true;
    wantedBy = [ "default.target" ];
    description = "prevent suspending system when audio is playing";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit'';
      Restart = "on-failure";
    };
  };
}
