{ pkgs, config, ... }:
let
rofi-power-menu = pkgs.stdenv.mkDerivation {
  name = "rofi-power-menu";
  src = builtins.fetchurl {
    url = "https://github.com/jluttine/rofi-power-menu/raw/395c1e07360b2dbd13c0a658665ab0a581024ec3/rofi-power-menu";
    sha256 = "3cfdf4cfb3553a62f56b055ed039e29c56abc063e9252cfbc3c7d3b5c98dfbb6";
  };
  buildCommand = ''
    mkdir -p $out/bin/
    cp $src $out/bin/rofi-power-menu
    chmod +x $out/bin/rofi-power-menu
    '';
};
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # enableNvidiaPatches = true; # was apparently removed
    xwayland.enable = true;
    settings = {
      input = {
        kb_layout = "de";
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };
      monitor = [
        "DP-1, 1920x1080, 0x0, 1"
        "DP-2, 1920x1080@144, 1920x0, 1"
        "HDMI-A-0, 1920x1080, 3840x0, 1"
        "Unknown-1,disable"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1,7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_is_master = true;
        orientation = "right";
      };
      gestures = {
        workspace_swipe = true;
      };
      "$mod" = "SUPER";
      workspace = "1,monitor:DP-2";
      bind = [
        "$mod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
        "$mod, Q, killactive,"
        "$mod SHIFT, R, exec, ${pkgs.rofi-wayland}/bin/rofi -show power-menu -modi power-menu:${rofi-power-menu}"
        "$mod SHIFT, M, togglefloating,"
        "$mod, G, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"
        "$mod, P, pseudo, # dwindle"
        "$mod, R, togglesplit, # dwindle"
        "$mod, B, fullscreen, 1"
        "$mod CTRL, B, fullscreen, 0"
        "$mod SHIFT, B, fakefullscreen"
        "$mod SHIFT, D, togglegroup"
        "$mod, D, changegroupactive, previous"
        "$mod, tab, workspace, previous"
        "$mod, n, togglespecialworkspace"
        # "$mod, BACKSPACE, exec, sed -i '/workman/{ ; 4s/ workman// ; b ; } ; 4s/$/ workman/' ~/.config/hypr/input.conf"
        "$mod, a, movefocus, l"
        "$mod, t, movefocus, r"
        "$mod, h, movefocus, u"
        "$mod, s, movefocus, d"
        "$mod SHIFT, a, movewindow, l"
        "$mod SHIFT, t, movewindow, r"
        "$mod SHIFT, h, movewindow, u"
        "$mod SHIFT, s, movewindow, d"
        "$mod CTRL, a, resizeactive, -20 0"
        "$mod CTRL, t, resizeactive, 20 0"
        "$mod CTRL, h, resizeactive, 0 -20"
        "$mod CTRL, s, resizeactive, 0 20"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod, X, workspace, m+1"
        "$mod, Z, workspace, m-1"
        # "$mod, mouse:272, movewindow"
        # "$mod, mouse:273, resizewindow"
        "$mod, less, exec, ${pkgs.hyprshot}/bin/hyprshot"
        ", XF86MonBrightnessDown, exec, ${pkgs.brillo}/bin/brillo -U 5"
        ", XF86MonBrightnessUp, exec, ${pkgs.brillo}/bin/brillo -A 5"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      # windowrulev2 = [
      #   "nomaxsize, class:^(riotclientux.exe)$,title:^(Riot Client Main)$"
      #   "float, class:^(riotclientux.exe)$,title:^(Riot Client Main)$"
      #   "size 1540 850, class:^(riotclientux.exe)$,title:^(Riot Client Main)$"
      #   "center, class:^(riotclientux.exe)$,title:^(Riot Client Main)$"
      #   ""
      #   "nomaxsize, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
      #   "float, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
      #   "size 1600 900,class:^(leagueclientux.exe)$,title:^(League of Legends)$"
      #   "center, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
      #   "opacity 1.0 override 1.0 override, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
      #   ""
      #   "opacity 1.0 override 1.0 override, class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$"
      #   "float, class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$"
      #   "nomaxsize, class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$"
      #   "fullscreen, class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$ # doesn't seem to work"
      # ];
    };
  };
}
