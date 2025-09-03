{ pkgs, config, user, lib, ... }:
{
  programs.hyprland = {
    enable = lib.mkDefault (config.home-manager.users.${user}.wayland.windowManager.hyprland.enable or false);
    xwayland.enable = true;
  };
  services.displayManager.defaultSession = pkgs.lib.mkIf config.programs.hyprland.enable "hyprland";
  systemd.user.services.sway-audio-idle-inhibit = {
    enable = config.programs.hyprland.enable;
    wantedBy = [ "default.target" ];
    description = "prevent suspending system when audio is playing";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit'';
      Restart = "on-failure";
      RestartSec = 30;
    };
  };
}
