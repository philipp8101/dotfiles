{ pkgs, config, inputs, system, ... }:
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
  lib = pkgs.lib;
  secondaryDisplay = lib.lists.remove config.primaryDisplay config.displays;
in
{
  config.wayland.windowManager.hyprland = {
    xwayland.enable = true;
    settings = {
      input = {
        kb_layout = "de";
        touchpad = {
          natural_scroll = "yes";
        };
        sensitivity = 0;
      };
      exec-once = [
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
        "${inputs.hyprpaper-custom.packages.${system}.default}/bin/hyprpaper"
        "${pkgs.hypridle}/bin/hypridle"
      ];
      monitor = map (x: "${x.identifier}, ${x.resolution}@${lib.strings.floatToString x.refreshrate}, ${x.offset}, ${lib.strings.floatToString x.scale}") config.displays ++ [
        "Unknown-1,disable"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(${config.colorScheme.palette.base0D}ee) rgba(${config.colorScheme.palette.base0B}ee) 45deg";
        "col.inactive_border" = "rgba(${config.colorScheme.palette.base02}aa)";
      };
      decoration = {
        rounding = 10;
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
        orientation = "right";
      };
      "$mod" = "SUPER";
      workspace = [
        "1,monitor:${config.primaryDisplay.identifier}"
      ] ++ lib.lists.optionals (lib.lists.length secondaryDisplay >= 1) [
        "4,monitor:${(builtins.elemAt secondaryDisplay 0).identifier}"
        "8,monitor:${(builtins.elemAt secondaryDisplay 0).identifier}"
      ];
      bind = [
        "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
        "$mod, Q, killactive,"
        "$mod SHIFT, Q, forcekillactive,"
        "$mod CTRL, B, fullscreen, 0"
        "$mod, U, exec, rofi -show calc -modi calc -no-show-match -no-sort"
        "$mod, P, pseudo, # dwindle"
        "$mod, t, workspace, 1"
        "$mod, h, workspace, 2"
        "$mod, s, workspace, 3"
        "$mod, a, workspace, 4"
        "$mod, n, workspace, 5"
        "$mod, e, workspace, 6"
        "$mod, o, workspace, 7"
        "$mod, i, workspace, 8"
        "$mod SHIFT, t, movetoworkspace, 1"
        "$mod SHIFT, h, movetoworkspace, 2"
        "$mod SHIFT, s, movetoworkspace, 3"
        "$mod SHIFT, a, movetoworkspace, 4"
        "$mod SHIFT, n, movetoworkspace, 5"
        "$mod SHIFT, e, movetoworkspace, 6"
        "$mod SHIFT, o, movetoworkspace, 7"
        "$mod SHIFT, i, movetoworkspace, 8"
        "$mod, G, exec, rofi -show drun"
        "$mod, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -z -m region --clipboard-only"
        "$mod SHIFT, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -z -m region --clipboard-only --raw | ${pkgs.tesseract}/bin/tesseract stdin stdout -l eng | wl-copy"
        "$mod, X, togglefloating,"
        "$mod, M, movecurrentworkspacetomonitor, l"
        "$mod, C, movecurrentworkspacetomonitor, r"
        "$mod, V, exec, rofi -show power-menu -modi power-menu:${rofi-power-menu}/bin/rofi-power-menu"
        "$mod CTRL, left, resizeactive, -20 0"
        "$mod CTRL, right, resizeactive, 20 0"
        "$mod CTRL, up, resizeactive, 0 -20"
        "$mod CTRL, down, resizeactive, 0 20"
        ", XF86MonBrightnessDown, exec, ${pkgs.brillo}/bin/brillo -U 5"
        ", XF86MonBrightnessUp, exec, ${pkgs.brillo}/bin/brillo -A 5"
        "$mod, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | ${pkgs.jq}/bin/jq '.float * 1.3')"
        "$mod, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | ${pkgs.jq}/bin/jq '(.float * 0.7) | if . < 1 then 1 else . end')"
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
      windowrulev2 = [
        "workspace 8, class:(vesktop)"
        "workspace 8, class:(discord)"
      ];
      binds.scroll_event_delay = 50;
      ecosystem.no_update_news = true;
      ecosystem.no_donation_nag = true;
      misc.enable_anr_dialog = false; # anr = application not responding
    };
  };
}
