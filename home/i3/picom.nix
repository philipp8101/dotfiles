{ pkgs, config, ... }:
{
  services.picom = {
    enable = config.xsession.windowManager.i3.enable;
    # backend = "glx";
    fade = true;
    fadeDelta = 4;
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 3;
      };
    };
  };
} 
