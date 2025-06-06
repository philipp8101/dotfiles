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
  options.wayland.windowManager.hyprland.layout = lib.mkOption {
    type = with lib.types; enum [ "dwindle" "master" "scroller" ];
    default = "dwindle";
  };
  config.wayland.windowManager.hyprland = {
    xwayland.enable = true;
    plugins = (with pkgs.hyprlandPlugins; [
      # hyprwinwrap # broken?
      (lib.mkIf (config.wayland.windowManager.hyprland.layout == "scroller") hyprscroller)
      hyprspace
    ]);
    settings = {
      plugin = {
        hyprwinwrap = {
          title = [
            "gifview"
          ];
        };
        scroller = {
          focus_wrap = "false";
          column_widths = "onehalf one";
        };
        overview.showEmptyWorkspace = false;
      };
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
        layout = config.wayland.windowManager.hyprland.layout;
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
      gestures = {
        workspace_swipe = true;
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
        "$mod, G, exec, walker"
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
      ] ++ lib.lists.optionals (config.wayland.windowManager.hyprland.layout != "scroller") [
        "$mod, D, changegroupactive, previous"
        "$mod SHIFT, D, togglegroup"
        "$mod, R, togglesplit, # dwindle"
        "$mod, W, overview:toggle"
        "$mod, B, fullscreen, 1"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
      ] ++ lib.lists.optionals (config.wayland.windowManager.hyprland.layout == "scroller") [
        "$mod, D, scroller:admitwindow"
        "$mod, R, scroller:expelwindow"
        "$mod, W, scroller:setmode, r"
        "$mod SHIFT, W, scroller:setmode, c"
        "$mod, B, scroller:cyclesize, next"
        "$mod, left, scroller:movefocus, l"
        "$mod, right, scroller:movefocus, r"
        "$mod, up, scroller:movefocus, u"
        "$mod, down, scroller:movefocus, d"
        "$mod SHIFT, left, scroller:movewindow, l"
        "$mod SHIFT, right, scroller:movewindow, r"
        "$mod SHIFT, up, scroller:movewindow, u"
        "$mod SHIFT, down, scroller:movewindow, d"
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
    };
  };
}
