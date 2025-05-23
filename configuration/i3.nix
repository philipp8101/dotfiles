{ pkgs, config, lib, user, ... }:
{
  services.xserver = {
    enable = config.services.xserver.windowManager.i3.enable;
    resolutions = [
      { x = 1920; y = 1080; }
    ];
    windowManager.i3 = {
    enable = lib.mkDefault (config.home-manager.users.${user}.xsession.windowManager.i3.enable or false);
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        polybarFull
        dunst
        rofi
      ];
    };
  };
}
