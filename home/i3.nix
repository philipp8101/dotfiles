{ pkgs, config, system, inputs, ... }:
let
mod = "Mod4";
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
scripts = import ./i3scripts.nix {inherit pkgs;};
in
{
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = ''
      show_marks yes
      default_border pixel 3
    '';
    config = {
      fonts = {
        names = [ "Inconsolata Nerd Font" ];
        style = "Regular";
        size = 10.0;
      };
      modifier = mod;
      floating.modifier = mod;
      focus.followMouse = true;
      focus.newWindow = "urgent";
      focus.wrapping = "no";
      gaps = {
        inner = 5;
        outer = 5;
      };
      bars = [];
      keybindings = {
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${mod}+Shift+Return" = "exec \"${scripts}/bin/next_empty_workspace.py ; ${pkgs.alacritty}/bin/alacritty\"";
        "${mod}+z" = "exec ${pkgs.flameshot}/bin/flameshot gui";
        "${mod}+Shift+z" = "exec ${pkgs.flameshot}/bin/flameshot gui --raw | ${pkgs.tesseract}/bin/tesseract stdin stdout -l eng | ${pkgs.xclip}/bin/xclip -in -selection clipboard";
        "${mod}+q" = "kill";
        "--release button2" = "kill";
        "${mod}+g" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${mod}+Shift+g" = "exec \"${scripts}/bin/next_empty_workspace.py ; ${pkgs.rofi}/bin/rofi -show drun\"";
        "${mod}+v" = "exec ${pkgs.rofi}/bin/rofi -show power-menu -modi power-menu:${rofi-power-menu.outPath}/bin/rofi-power-menu";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        "${mod}+Control+Left" = "resize shrink width 5 px or 5 ppt";
        "${mod}+Control+Down" = "resize shrink height 5 px or 5 ppt";
        "${mod}+Control+Up" = "resize grow height 5 px or 5 ppt";
        "${mod}+Control+Right" = "resize grow width 5 px or 5 ppt";
        "${mod}+b" = "fullscreen toggle";
        "${mod}+w" = "layout stacking";
        "${mod}+d" = "layout tabbed";
        "${mod}+r" = "layout toggle split";
        "${mod}+x" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+p" = "focus parent";
        "${mod}+Tab" = "exec ${scripts}/bin/focus_last_workspace_on_output.py";
        "${mod}+m" = "move workspace to output left";
        "${mod}+c" = "move workspace to output right";
        "${mod}+Control+m" = "reload";
        "${mod}+Control+r" = "restart";
        # "${mod}+z" = "workspace prev_on_output";
        # "${mod}+x" = "workspace next_on_output";
        # "${mod}+Shift+z" = "exec ${scripts}/bin/move_to_next_workspace.py";
        # "${mod}+Shift+x" = "exec ${scripts}/bin/move_and_switch_to_next_workspace.py";
        # "${mod}+$alt+a" = "move container to workspace prev_on_output";
        # "${mod}+$alt+t" = "move container to workspace next_on_output";
        # custom rofi scripts, provide i3 commands separated by ´-´ in the {mod}e variable
        "${mod}+f" = "exec mode=workspace ${pkgs.rofi}/bin/rofi -show 'go to workspace' -modes 'go to workspace:${scripts}/bin/rofi_menu.py'";
        "${mod}+k" = "exec ${pkgs.mosquitto}/bin/mosquitto_pub -h localhost -t 'desk/control-height' -m 'down'";
        "${mod}+l" = "exec ${pkgs.mosquitto}/bin/mosquitto_pub -h localhost -t 'desk/control-height' -m 'up'";
        "${mod}+comma" = "exec ${pkgs.mosquitto}/bin/mosquitto_pub -h localhost -t 'desk/control-height' -m 'p1'";
        "${mod}+period" = "exec ${pkgs.mosquitto}/bin/mosquitto_pub -h localhost -t 'desk/control-height' -m 'p2'";
        "${mod}+minus" = "exec ${pkgs.mosquitto}/bin/mosquitto_pub -h localhost -t 'desk/control-height' -m 'p3'";
        "${mod}+y" = "gaps horizontal current set 5";
        "${mod}+Shift+y" = "gaps horizontal current set 350";
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume @DEFAULT_SINK@ +10%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudioFull}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.pulseaudioFull}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86AudioPlay" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
        "${mod}+u" = "exec ${pkgs.rofi}/bin/rofi -show calc -modi calc -no-show-match -no-sort";
        # bindsym ${mod}+p exec ${pkgs.rofi}/bin/rofi -show time -modi time:~/.config/rofi/rofi-scripts/time.py
        "${mod}+t" = "workspace 1";
        "${mod}+h" = "workspace 2";
        "${mod}+s" = "workspace 3";
        "${mod}+a" = "workspace 4";
        "${mod}+n" = "workspace 5";
        "${mod}+e" = "workspace 6";
        "${mod}+o" = "workspace 7";
        "${mod}+i" = "workspace 8";
        "${mod}+Shift+t" = "move container to workspace number 1";
        "${mod}+Shift+h" = "move container to workspace number 2";
        "${mod}+Shift+s" = "move container to workspace number 3";
        "${mod}+Shift+a" = "move container to workspace number 4";
        "${mod}+Shift+n" = "move container to workspace number 5";
        "${mod}+Shift+e" = "move container to workspace number 6";
        "${mod}+Shift+o" = "move container to workspace number 7";
        "${mod}+Shift+i" = "move container to workspace number 8";
      };
      assigns = {
        "6" = [{class="Steam";}{class="steam";}{title="Steam";}{title="steam";}];
        "7" = [{instance="^league";}{instance="^riot";}{title="^League";}{instance="upc.exe";}{instance="anno*";}{instance="origin.exe";}{instance="lutris";}];
        "8" = [{class="discord";}];
      };
      workspaceOutputAssign = [
        { output = "DP-2"; workspace = "1"; }
        { output = "DP-2"; workspace = "2"; }
        { output = "DP-2"; workspace = "3"; }
        { output = "DP-0"; workspace = "4"; }
        { output = "DP-2"; workspace = "5"; }
        { output = "DP-2"; workspace = "6"; }
        { output = "DP-2"; workspace = "7"; }
        { output = "HDMI-0"; workspace = "8"; }
      ];
      # command criteria
      # all - matches all windows
      # class - second part of WM_CLASS
      # instance - frist part of WM_CLASS
      # window_role - WM_WINDOW_ROLE
      # window_type - _NET_WM_WINDOW_TYPE
      # machine - WM_CLIENT_MACHINE
      # id - xwininfo window_id
      # title - _NET_WM_NAME or WM_NAME
      # urgent - "latest" or "oldest" matches urgent windows
      # workspace - matches workspace name
      # con_mark - matches containers mark name
      # con_id - internal i3 id accessible via i3ips
      # floating - matches floating windows
      # floating_from - "auto" (windows automatically opened as floating) or "user" (windows that were made floating dy user)
      # tiling - match tiled windows
      # tiling_from - same as floating_from
      window.commands = [
        { command = "floating enable"; criteria = { window_role = "task_dialog"; }; }
        { command = "floating enable"; criteria = { instance="origin.exe"; }; }
        { command = "resize set width 15 ppt"; criteria = { class="Steam"; title="Friends List"; }; }
        { command = "floating enable"; criteria = { class="Steam"; title="Steam Guard"; }; }
        { command = "floating enable"; criteria = { class="Steam"; title="Steam - News"; }; }
        { command = "border pixel 3"; criteria = { class="firefox"; }; }
        { command = "floating enable"; criteria = { instance="Places"; class="firefox"; }; }
        { command = "border pixel 3"; criteria = { class="Alacritty"; }; }
        { command = "border pixel 3"; criteria = { class="kitty"; }; }
        # insert new containers to mark
        #bindsym $mod+p move container to mark insert
        #bindsym $mod+Control+p mark --toggle insert
        { command = "move container to mark insert"; criteria = {window_type="normal";};}
      ];
      colors = {
        background = "#${config.colorScheme.palette.base00}";
        focused = {
          border = "#${config.colorScheme.palette.base04}";
          background = "#${config.colorScheme.palette.base04}";
          text = "#${config.colorScheme.palette.base01}";
          indicator = "#${config.colorScheme.palette.base03}";
          childBorder = "#${config.colorScheme.palette.base03}";
        };
        focusedInactive = {
          border = "#${config.colorScheme.palette.base02}";
          background = "#${config.colorScheme.palette.base02}";
          text = "#${config.colorScheme.palette.base05}";
          indicator = "#${config.colorScheme.palette.base02}";
          childBorder = "#${config.colorScheme.palette.base02}";
        };
        unfocused = {
          border = "#${config.colorScheme.palette.base00}";
          background = "#${config.colorScheme.palette.base00}";
          text = "#${config.colorScheme.palette.base05}";
          indicator = "#${config.colorScheme.palette.base00}";
          childBorder = "#${config.colorScheme.palette.base00}";
        };
        urgent = {
          border = "#${config.colorScheme.palette.base08}";
          background = "#${config.colorScheme.palette.base08}";
          text = "#${config.colorScheme.palette.base05}";
          indicator = "#${config.colorScheme.palette.base08}";
          childBorder = "#${config.colorScheme.palette.base08}";
        };
        placeholder = {
          border = "#${config.colorScheme.palette.base00}";
          background = "#${config.colorScheme.palette.base00}";
          text = "#${config.colorScheme.palette.base05}";
          indicator = "#${config.colorScheme.palette.base00}";
          childBorder = "#${config.colorScheme.palette.base00}";
        };
      };
    };
  };
}
