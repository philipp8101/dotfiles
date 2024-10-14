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
nix-run-rofi = pkgs.writeShellScriptBin "nix-run-rofi.sh" ''
if [ -z $1 ] ; then
    nix flake show nixpkgs --legacy --json |nix run nixpkgs#jq -- -r '.legacyPackages.["x86_64-linux"] | keys_unsorted[]'
else
    nohup nix run nixpkgs#$1 > /dev/null &
fi
'';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # enableNvidiaPatches = true; # was apparently removed
    xwayland.enable = true;
    plugins = [

    ];
    settings = {
      input = {
        kb_layout = "de";
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };
      exec-once = [
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
      ];
      monitor = [
        "DP-1, 1920x1080, 0x0, 1"
        "DP-2, 1920x1080@144, 1920x0, 1"
        "HDMI-A-0, 1920x1080, 3840x0, 1"
        "Unknown-1,disable"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 5;
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
        orientation = "right";
      };
      gestures = {
        workspace_swipe = true;
      };
      "$mod" = "SUPER";
      workspace = "1,monitor:DP-2";
      bind = [
        "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
        "$mod, Q, killactive,"
        "$mod, D, changegroupactive, previous"
        "$mod SHIFT, D, togglegroup"
        "$mod, R, togglesplit, # dwindle"
        "$mod, B, fullscreen, 1"
        "$mod CTRL, B, fullscreen, 0"
        "$mod SHIFT, B, fakefullscreen"
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
        "$mod, G, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"
        "$mod SHIFT, G, exec, ${pkgs.rofi-wayland}/bin/rofi -show nix-run -modi nix-run:${nix-run-rofi}/bin/nix-run-rofi.sh"
        "$mod, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m region --clipboard-only"
        "$mod, X, togglefloating,"
        "$mod, M, movecurrentworkspacetomonitor, -1"
        "$mod, C, movecurrentworkspacetomonitor, +1"
        "$mod, V, exec, ${pkgs.rofi-wayland}/bin/rofi -show power-menu -modi power-menu:${rofi-power-menu}/bin/rofi-power-menu"
        # "$mod, BACKSPACE, exec, sed -i '/workman/{ ; 4s/ workman// ; b ; } ; 4s/$/ workman/' ~/.config/hypr/input.conf"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod CTRL, left, resizeactive, -20 0"
        "$mod CTRL, right, resizeactive, 20 0"
        "$mod CTRL, up, resizeactive, 0 -20"
        "$mod CTRL, down, resizeactive, 0 20"
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
