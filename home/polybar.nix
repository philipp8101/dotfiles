{ pkgs, config, ...}:
{
    services.polybar = {
        enable = true;
        script = "polybar primary";
        package = pkgs.polybarFull;
        settings = {
            "bar/primary" = {
                monitor = "\${env:MONITOR:}";
                width = "100%";
                height = "27";
                fixed-center = "true";
                background = "#${config.colorScheme.colors.base00}3a";
                foreground = "#${config.colorScheme.colors.base05}";
                line-size = "3";
                border-bottom-size = "3";
                border-color = "#${config.colorScheme.colors.base03}";
                padding-left = "2";
                padding-right = "2";
                module-margin-left = "1";
                module-margin-right = "1";
                font-0 = "Inconsolata:style=regular:size=11;2";
                font-1 = "Inconsolata Nerd Font Mono:style=Regular:size=16;2";
                modules-left = "ws-move-left i3 ws-add ws-move-right";
                modules-center = "date-script";
                modules-right = "headset-battery pulseaudio-control";
                tray-position = "none";
                tray-padding = "2";
                cursor-click = "pointer";
                cursor-scroll = "ns-resize";
                enable-ipc = "true";
            };
            "bar/auxilary" = {
                "inherit" = "bar/primary";
                monitor = "\${env:MONITOR}";
                tray-position = "none";
                modules-right = "temp desk";
            };
            "bar/secondary" = {
                "inherit" = "bar/primary";
                monitor = "\${env:MONITOR}";
                tray-position = "right";
                modules-right = "updates disk";
            };
            "bar/single" = {
                "inherit" = "bar/primary";
                monitor = "\${env:MONITOR}";
                tray-position = "right";
            };
            "module/i3" = {
                type = "internal/i3";
                format = "<label-state> <label-mode>";
                index-sort = "true";
                wrapping-scroll = "false";
                strip-wsnumbers = "true";
                pin-workspaces = "true";
                label-mode-padding = "2";
                label-mode-foreground = "#000";
                label-mode-background = "#${config.colorScheme.colors.base00}3a";
                label-focused = "%name%";
                label-focused-background = "#${config.colorScheme.colors.base01}30";
                label-focused-underline = "#${config.colorScheme.colors.base09}";
                label-focused-padding = "2";
                label-unfocused = "%name%";
                label-unfocused-padding = "2";
                label-visible = "%name%";
                label-visible-background = "\${self.label-focused-background}";
                label-visible-underline = "#${config.colorScheme.colors.base0D}";
                label-visible-padding = "\${self.label-focused-padding}";
                label-urgent = "%name%";
                label-urgent-background = "#${config.colorScheme.colors.base08}";
                label-urgent-padding = "2";
            };
            "module/date-script" = {
                type = "custom/script";
                exec = ''
                    ${pkgs.coreutils-full}/bin/date "+%{F#6e738d}KW%V "$(${pkgs.coreutils-full}/bin/expr 52 + $(${pkgs.coreutils-full}/bin/date +%V))"  -%{F-} %A - %d.%m.%Y - %H:%M:%S %{F#6e738d}- %Z%{F-}"
                '';
                click-left = ''
                    ${pkgs.yad}/bin/yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons --posx=445 --posy=95        --title="calendar" --borders=0
                '';
                interval = "1";
            };
            "module/battery" = {
                type = "internal/battery";
                battery = "BAT0";
                adapter = "ADP1";
                full-at = "98";
                format-charging = "<animation-charging> <label-charging>";
                format-charging-underline = "#ffb52a";
                format-discharging = "<animation-discharging> <label-discharging>";
                format-discharging-underline = "\${self.format-charging-underline}";
                format-full-prefix = " ";
                format-full-prefix-foreground = "#${config.colorScheme.colors.base05}";
                format-full-underline = "\${self.format-charging-underline}";
                ramp-capacity-0 = "";
                ramp-capacity-1 = "";
                ramp-capacity-2 = "";
                ramp-capacity-foreground = "#${config.colorScheme.colors.base05}";
                animation-charging-0 = "";
                animation-charging-1 = "";
                animation-charging-2 = "";
                animation-charging-foreground = "#${config.colorScheme.colors.base05}";
                animation-charging-framerate = "750";
                animation-discharging-0 = "";
                animation-discharging-1 = "";
                animation-discharging-2 = "";
                animation-discharging-foreground = "#${config.colorScheme.colors.base05}";
                animation-discharging-framerate = "750";
            };
            "settings" = {
                screenchange-reload = "true";
            };
            "global/wm" = {
                margin-top = "5";
                margin-bottom = "5";
            };
            "module/desk" = {
                type = "custom/script";
                tail = "true";
                exec = "~/.config/polybar/polybar-scripts/desk-height.sh";
                format-prefix = "󱈹 ";
                scroll-up = "~/.config/polybar/polybar-scripts/desk-height.sh up";
                scroll-down = "~/.config/polybar/polybar-scripts/desk-height.sh down";
            };
            "module/updates" = {
                type = "custom/script";
                exec = "~/.config/polybar/polybar-scripts/pacman-updates.sh";
                interval = "30";
            };
            "module/disk" = {
                type = "custom/script";
                exec = "~/.config/polybar/polybar-scripts/disk-usage.sh";
                interval = "300";
            };
            "module/pulseaudio-control" = {
                type = "custom/script";
                tail = "true";
                label-padding = "2";
                exec = "~/.config/polybar/polybar-scripts/pactl.sh";
                click-right = "~/.config/polybar/polybar-scripts/pactl.sh --rclick";
                click-left = "~/.config/polybar/polybar-scripts/pactl.sh --lclick";
                click-middle = "~/.config/polybar/polybar-scripts/pactl.sh --mclick";
                scroll-up = "~/.config/polybar/polybar-scripts/pactl.sh --scroll-up";
                scroll-down = "~/.config/polybar/polybar-scripts/pactl.sh --scroll-down";
            };
            "module/ws-move-left" = {
                type = "custom/script";
                exec = "echo ";
                click-left = "i3-msg move workspace to output left";
            };
            "module/ws-move-right" = {
                type = "custom/script";
                exec = "echo ";
                click-left = "i3-msg move workspace to output right";
            };
            "module/ws-add" = {
                type = "custom/script";
                exec = "echo 󰐕";
                click-left = "~/.config/i3/scripts/next_empty_workspace.py ; rofi -show drun -theme round";
            };
            "module/spotify-next" = {
                type = "custom/script";
                exec = "echo  ";
                format = "<label>";
                click-left = "playerctl next -p spotify";
            };
            "module/headset-battery" = {
                type = "custom/script";
                interval = "2";
                exec = "~/.config/polybar/polybar-scripts/headset-battery.sh";
            };
            "module/temp" = {
                type = "custom/script";
                exec = "~/.config/polybar/polybar-scripts/temp.sh";
                interval = "5";
            };
        };
    };
}
