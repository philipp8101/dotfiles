{ pkgs, config, ...}:
let
    polybar-pulseaudio-control = builtins.fetchurl {
      url = "https://github.com/marioortizmanero/polybar-pulseaudio-control/raw/ed03a1b85dd0e92f85bc7446b78e010b36be4606/pulseaudio-control";
      sha256 = "46b5de0f4724c9088a30278d470ba97c3c0a4489dc2d71cde0da2c177c7297f4";
    };
    ppc-cmd = "PATH=${pkgs.pulseaudio}/bin:${pkgs.coreutils-full}/bin:${pkgs.gnugrep}/bin ${pkgs.bash}/bin/bash ${polybar-pulseaudio-control}";
in
{
    xdg.configFile."polybar/polybar-scripts".source = ./polybar/polybar-scripts;
    services.polybar = {
        enable = true;
        script = "polybar primary &";
        package = pkgs.polybarFull;
        settings = {
            "bar/primary" = {
                monitor = "\${env:MONITOR:}";
                width = "100%";
                height = "27";
                fixed-center = "true";
                background = "#aa${config.colorScheme.palette.base00}";
                foreground = "#${config.colorScheme.palette.base05}";
                line-size = "3";
                border-bottom-size = "3";
                border-color = "#${config.colorScheme.palette.base03}";
                padding-left = "2";
                padding-right = "2";
                module-margin-left = "1";
                module-margin-right = "1";
                font-0 = "Inconsolata:style=regular:size=11;2";
                font-1 = "Inconsolata Nerd Font Mono:style=Regular:size=21;5";
                modules-left = "ws-move-left i3 ws-add ws-move-right";
                modules-center = "date-script";
                modules-right = "disk headset-battery pulseaudio-control temp tray";
                cursor-click = "pointer";
                cursor-scroll = "ns-resize";
                enable-ipc = "true";
            };
            "bar/auxilary" = {
                "inherit" = "bar/primary";
                monitor = "\${env:MONITOR}";
                modules-right = "temp desk";
            };
            "bar/secondary" = {
                "inherit" = "bar/primary";
                monitor = "\${env:MONITOR}";
                modules-right = "updates disk";
            };
            "bar/single" = {
                "inherit" = "bar/primary";
                monitor = "\${env:MONITOR}";
            };
            "module/tray" = {
                type = "internal/tray";
                tray-padding = "2";
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
                label-mode-background = "#${config.colorScheme.palette.base00}3a";
                label-focused = "%name%";
                label-focused-background = "#${config.colorScheme.palette.base01}30";
                label-focused-underline = "#${config.colorScheme.palette.base09}";
                label-focused-padding = "2";
                label-unfocused = "%name%";
                label-unfocused-padding = "2";
                label-visible = "%name%";
                label-visible-background = "\${self.label-focused-background}";
                label-visible-underline = "#${config.colorScheme.palette.base0D}";
                label-visible-padding = "\${self.label-focused-padding}";
                label-urgent = "%name%";
                label-urgent-background = "#${config.colorScheme.palette.base08}";
                label-urgent-padding = "2";
            };
            "module/date-script" = {
                type = "custom/script";
                exec = ''
                    ${pkgs.coreutils-full}/bin/date "+%{F#6e738d}KW%V "$(${pkgs.coreutils-full}/bin/expr 52 + $(${pkgs.coreutils-full}/bin/date +%V))"  -%{F-} %A - %d.%m.%Y - %H:%M:%S %{F#6e738d}- %Z%{F-}"
                '';
                click-left = ''
                    ${pkgs.yad}/bin/yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons --posx=900 --posy=20        --title="calendar" --borders=0
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
                format-full-prefix-foreground = "#${config.colorScheme.palette.base05}";
                format-full-underline = "\${self.format-charging-underline}";
                ramp-capacity-0 = "";
                ramp-capacity-1 = "";
                ramp-capacity-2 = "";
                ramp-capacity-foreground = "#${config.colorScheme.palette.base05}";
                animation-charging-0 = "";
                animation-charging-1 = "";
                animation-charging-2 = "";
                animation-charging-foreground = "#${config.colorScheme.palette.base05}";
                animation-charging-framerate = "750";
                animation-discharging-0 = "";
                animation-discharging-1 = "";
                animation-discharging-2 = "";
                animation-discharging-foreground = "#${config.colorScheme.palette.base05}";
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
                exec = ''
                    ${pkgs.mosquitto}/bin/mosquitto_sub -h 192.168.0.5 -t "desk/current-height" -u mosquitto -P Y3Gnwwo= 2> /dev/null
                '';
                format-prefix = "󱈹 ";
                scroll-up = ''
                    ${pkgs.mosquitto}/bin/mosquitto_pub -h 192.168.0.5 -t "desk/control-height" -u mosquitto -P Y3Gnwwo= -m "up"
                '';
                scroll-down = ''
                    ${pkgs.mosquitto}/bin/mosquitto_pub -h 192.168.0.5 -t "desk/control-height" -u mosquitto -P Y3Gnwwo= -m "down"
                '';
            };
            "module/disk" = {
                type = "custom/script";
                exec = "PATH=${pkgs.bash}/bin:${pkgs.gawk}/bin:${pkgs.coreutils-full}/bin:${pkgs.zfs}/bin:${pkgs.smartmontools}/bin ~/.config/polybar/polybar-scripts/disk-usage.sh test";
                interval = "300";
            };
            "module/pulseaudio-control" = {
                type = "custom/script";
                tail = "true";
                label-padding = "2";
                exec = ''
                    ${ppc-cmd} --node-nicknames-from "device.description"  --node-nickname "alsa_output.usb-SteelSeries_Arctis_Pro_Wireless-00.analog-stereo:  Arctis Pro Wireless" --node-nickname "alsa_output.usb-SteelSeries_SteelSeries_Arctis_9_000000000000-00.stereo-game:  Arctis 9 Game" --node-nickname "alsa_output.usb-SteelSeries_SteelSeries_Arctis_9_000000000000-00.stereo-chat:  Arctis 9 Chat" --node-nickname "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1:  HDMI" --node-nickname "alsa_output.pci-0000_00_1f.3.analog-stereo:  Analog Stereo" --node-nickname "jack_out:JACK sink" listen
                '';
                click-left = "${ppc-cmd} togmute";
                click-middle = ''
                    ${ppc-cmd} --node-blacklist "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra2" --node-blacklist "alsa_output.pci-0000_01_00.1.hdmi-stereo" --node-blacklist "alsa_output.pci-0000_00_1f.3.iec958-stereo" --node-blacklist "alsa_output.pci-0000_01_00.1.hdmi-stereo" next-node
                '';
                scroll-up = ''
                    ${ppc-cmd} --volume-max 130 up
                '';
                scroll-down = ''
                    ${ppc-cmd} --volume-max 130 down
                '';
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
                click-left = "${pkgs.python3}/bin/python ~/.config/i3/scripts/next_empty_workspace.py ; rofi -show drun -theme round";
            };
            "module/headset-battery" = {
                type = "custom/script";
                interval = "2";
                exec = ''
                PATH=${pkgs.coreutils-full}/bin:${pkgs.gnugrep}/bin:${pkgs.headsetcontrol}/bin ${pkgs.bash}/bin/bash ~/.config/polybar/polybar-scripts/headset-battery.sh
                '';
            };
            "module/temp" = {
                type = "custom/script";
                exec = ''
                    ${pkgs.coreutils-full}/bin/echo "%{F#6e738d}CPU:%{F-}$(${pkgs.lm_sensors}/bin/sensors |${pkgs.gawk}/bin/awk '/Core/{if (0+substr($3,2,2)>0+max) a=substr($3,2,2)} END{print a}')°C"
                    # %{F#6e738d}GPU:%{F-}$(nvidia-smi -q|awk '/GPU Current Temp/{print $5}')°C"
                '';
                interval = "5";
            };
        };
    };
}
