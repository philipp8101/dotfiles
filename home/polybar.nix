services.polybar = {
    enable = true;
    settings = {
        "bar/primary" = {
            monitor = "${env:MONITOR:}";
            width = "100%";
            height = "27";
            fixed-center = "true";
            background = "${colors.base-transparent}";
            foreground = "${colors.text}";
            line-size = "3";
            border-bottom-size = "3";
            border-color = "${colors.surface1}";
            padding-left = "2";
            padding-right = "2";
            module-margin-left = "1";
            module-margin-right = "1";
            font-0 = "Inconsolata:style=regular:size=11;2";
            font-1 = "Inconsolata" Nerd Font Mono:style=Regular:size=16;2;
            modules-left = "ws-move-left" i3 ws-add ws-move-right ;
            modules-center = "date-script";
            modules-right = "rgb" headset-battery pulseaudio-control;
            tray-position = "none";
            tray-padding = "2";
            cursor-click = "pointer";
            cursor-scroll = "ns-resize";
            enable-ipc = "true";
        };
        "bar/auxilary" = {
            inherit = "bar/primary";
            monitor = "${env:MONITOR}";
            tray-position = "none";
            modules-right = "temp" desk ;
        };
        "bar/secondary" = {
            inherit = "bar/primary";
            monitor = "${env:MONITOR}";
            tray-position = "right";
            modules-right = "updates" disk;
        };
        "bar/single" = {
            inherit = "bar/primary";
            monitor = "${env:MONITOR}";
            tray-position = "right";
        };
        "module/i3" = {
            type = "internal/i3";
            format = "<label-state>" <label-mode>;
            index-sort = "true";
            wrapping-scroll = "false";
            strip-wsnumbers = "true";
            pin-workspaces = "true";
            label-mode-padding = "2";
            label-mode-foreground = "#000";
            label-mode-background = "${colors.base-transparent}";
            label-focused = "%name%";
            label-focused-background = "${colors.mantle-transparent}";
            label-focused-underline = "${colors.peach}";
            label-focused-padding = "2";
            label-unfocused = "%name%";
            label-unfocused-padding = "2";
            label-visible = "%name%";
            label-visible-background = "${self.label-focused-background}";
            label-visible-underline = "${colors.sapphire}";
            label-visible-padding = "${self.label-focused-padding}";
            label-urgent = "%name%";
            label-urgent-background = "${colors.maroon}";
            label-urgent-padding = "2";
        };
        "module/date-script" = {
            type = "custom/script";
            exec = "~/.config/polybar/polybar-scripts/date.sh";
            click-left = "~/.config/polybar/polybar-scripts/date.sh" --popup;
            interval = "1";
        };
        "module/battery" = {
            type = "internal/battery";
            battery = "BAT0";
            adapter = "ADP1";
            full-at = "98";
            format-charging = "<animation-charging>" <label-charging>;
            format-charging-underline = "#ffb52a";
            format-discharging = "<animation-discharging>" <label-discharging>;
            format-discharging-underline = "${self.format-charging-underline}";
            format-full-prefix = " "
                format-full-prefix-foreground = "${colors.foreground-alt}";
            format-full-underline = "${self.format-charging-underline}";
            ramp-capacity-0 = "";
            ramp-capacity-1 = "";
            ramp-capacity-2 = "";
            ramp-capacity-foreground = "${colors.foreground-alt}";
            animation-charging-0 = "";
            animation-charging-1 = "";
            animation-charging-2 = "";
            animation-charging-foreground = "${colors.foreground-alt}";
            animation-charging-framerate = "750";
            animation-discharging-0 = "";
            animation-discharging-1 = "";
            animation-discharging-2 = "";
            animation-discharging-foreground = "${colors.foreground-alt}";
            animation-discharging-framerate = "750";
        };
        "settings" = {
            screenchange-reload = "true";
        };
        "global/wm" = {
            include-file = "$HOME/.config/polybar/catpuccino-macchiato.ini";
            margin-top = "5";
            margin-bottom = "5";
        };
        "module/rgb" = {
            type = "custom/script";
            exec = "~/.config/polybar/polybar-scripts/rgb.sh";
            click-left = "~/.config/polybar/polybar-scripts/rgb.sh --toggle" 
        };
        "module/desk" = {
            type = "custom/script";
            tail = "true";
            exec = "~/.config/polybar/polybar-scripts/desk-height.sh";
            format-prefix = "󱈹 "
                scroll-up = "~/.config/polybar/polybar-scripts/desk-height.sh" up;
            scroll-down = "~/.config/polybar/polybar-scripts/desk-height.sh" down;
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
            label-foreground = "${colors.foreground}";
            exec = "~/.config/polybar/polybar-scripts/pactl.sh";
            click-right = "~/.config/polybar/polybar-scripts/pactl.sh" --rclick;
            click-left = "~/.config/polybar/polybar-scripts/pactl.sh" --lclick;
            click-middle = "~/.config/polybar/polybar-scripts/pactl.sh" --mclick;
            scroll-up = "~/.config/polybar/polybar-scripts/pactl.sh" --scroll-up;
            scroll-down = "~/.config/polybar/polybar-scripts/pactl.sh" --scroll-down;
        };
        "module/ws-move-left" = {
            type = "custom/script";
            exec = echo ""
                click-left = "i3-msg move workspace to output left"
        };
        "module/ws-move-right" = {
            type = "custom/script";
            exec = echo ""
                click-left = "i3-msg move workspace to output right"
        };
        "module/ws-add" = {
            type = "custom/script";
            exec = echo "󰐕"
                click-left = "~/.config/i3/scripts/next_empty_workspace.py ; rofi -show drun -theme round"
        };
        "module/spotify-next" = {
            type = "custom/script";
            exec = echo " "
                format = "<label>";
            click-left = "playerctl" next -p spotify;
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
