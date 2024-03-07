{ pkgs, config, ... }:
let
  rofi-power-menu = builtins.fetchurl {
    url = "https://github.com/jluttine/rofi-power-menu/raw/master/rofi-power-menu";
    sha256 = "3cfdf4cfb3553a62f56b055ed039e29c56abc063e9252cfbc3c7d3b5c98dfbb6";
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
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        col.inactive_border = "rgba(595959aa)";
        layout = "dwindle";
      };
      decorations = {
        rounding = 10;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        col.shadow = "rgba(1a1a1aee)";
      };
      animations = {
        enable = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1,7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspace, 1, 6, default"
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
      bind = [
        "$mainMod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, R, exec, ${pkgs.rofi}/bin/rofi -show power-menu -modi power-menu:${rofi-power-menu}"
        "$mainMod SHIFT, M, togglefloating,"
        "$mainMod, G, exec, ${pkgs.rofi}/bin/rofi -show drun"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, R, togglesplit, # dwindle"
        "$mainMod, B, fullscreen, 1"
        "$mainMod CTRL, B, fullscreen, 0"
        "$mainMod SHIFT, B, fakefullscreen"
        "$mainMod SHIFT, D, togglegroup"
        "$mainMod, D, changegroupactive, previous"
        "$mainMod, tab, workspace, previous"
        "$mainMod, n, togglespecialworkspace"
        "$mainMod, mouse:272, movewindow # mouse binds, if we change bind to bindm here the window will always be left floating "
        "$mainMod, mouse:273, resizewindow"
        # "$mainMod, BACKSPACE, exec, sed -i '/workman/{ ; 4s/ workman// ; b ; } ; 4s/$/ workman/' ~/.config/hypr/input.conf"
        "$mainMod, a, movefocus, l"
        "$mainMod, t, movefocus, r"
        "$mainMod, h, movefocus, u"
        "$mainMod, s, movefocus, d"
        "$mainMod SHIFT, a, movewindow, l"
        "$mainMod SHIFT, t, movewindow, r"
        "$mainMod SHIFT, h, movewindow, u"
        "$mainMod SHIFT, s, movewindow, d"
        "$mainMod CTRL, a, resizeactive, -20 0"
        "$mainMod CTRL, t, resizeactive, 20 0"
        "$mainMod CTRL, h, resizeactive, 0 -20"
        "$mainMod CTRL, s, resizeactive, 0 20"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, X, workspace, m+1"
        "$mainMod, Z, workspace, m-1"
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
        "$mainMod, less, exec, ${pkgs.hyprshot}/bin/hyprshot"
        ", XF86MonBrightnessDown, exec, ${pkgs.brillo}/bin/brillo -U 5"
        ", XF86MonBrightnessUp, exec, ${pkgs.brillo}/bin/brillo -A 5"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      windowrulev2 = [
        "nomaxsize, class:^(riotclientux.exe)$,title:^(Riot Client Main)$"
        "float, class:^(riotclientux.exe)$,title:^(Riot Client Main)$"
        "size 1540 850, class:^(riotclientux.exe)$,title:^(Riot Client Main)$"
        "center, class:^(riotclientux.exe)$,title:^(Riot Client Main)$"
        ""
        "nomaxsize, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
        "float, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
        "size 1600 900,class:^(leagueclientux.exe)$,title:^(League of Legends)$"
        "center, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
        "opacity 1.0 override 1.0 override, class:^(leagueclientux.exe)$,title:^(League of Legends)$"
        ""
        "opacity 1.0 override 1.0 override, class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$"
        "float, class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$"
        "nomaxsize, class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$"
        "fullscreen, class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$ # doesn't seem to work"
      ];
    };
  };
}
