{ pkgs, config, ... }:
{
    imports = [
        ./nix-colors.nix
    ];
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        systemd.target = "hyprland-session.target";
        settings = {
            mainBar = {
                layer= "top";
                position= "top";
                modules-left= ["hyprland/workspaces"];
                modules-center= ["clock"];
                modules-right= ["cpu" "memory" "network" "pulseaudio" "backlight" "battery" "backlight" "custom/weather" "tray"];
                tray= {
                    icon-size= 21;
                    spacing= 10;
                };
                "wayland/workspaces"= {
                    "disable-scroll"= true;
                    "format"= "{name} {icon}";
                    "format-icons"= {
                        "active"= " ";
                        "default"= " ";
                    };
                };
                clock= {
                    interval= 60;
                    max-length= 25;
                    format= "<span foreground='#C6AAE8'>    </span>KW{:%V  %a %d  %H:%M}";
                    tooltip-format= "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                };
                battery= {
                    states= {
                        warning= 30;
                        critical= 15;
                    };
                    format= "<span size='13000' foreground='#B1E3AD'>{icon}</span> {capacity}%";
                    format-warning= "<span size='13000' foreground='#B1E3AD'>{icon}</span> {capacity}%";
                    format-critical= "<span size='13000' foreground='#E38C8F'>{icon}</span> {capacity}%";
                    format-charging= "<span size='13000' foreground='#B1E3AD'> </span>{capacity}%";
                    format-plugged= "<span size='13000' foreground='#B1E3AD'> </span>{capacity}%";
                    format-alt= "<span size='13000' foreground='#B1E3AD'>{icon}</span> {time}";
                    format-full= "<span size='13000' foreground='#B1E3AD'> </span>{capacity}%";
                    format-icons= [" " " " " " " " " "];
                    tooltip-format= "{time}";
                };
                cpu= {
                    interval= 1;
                    format= "   {}%";
                    max-length= 10;
                };
                memory= {
                    interval= 1;
                    format= "   {}%";
                    max-length= 10;
                };
                network= {
                    format-wifi= "<span size='13000' foreground='#F2CECF'>  </span>{essid}";
                    format-ethernet= "<span size='13000' foreground='#F2CECF'>󰈀 </span>{ipaddr}";
                    format-linked= "{ifname} (No IP) ";
                    format-disconnected= "<span size='13000' foreground='#F2CECF'> </span>Disconnected";
                    tooltip-format-wifi= "Signal Strenght: {signalStrength}%";
                };
                pulseaudio= {
                    on-click= "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                    format= "<span size='13000' foreground='#EBDDAA'>{icon} </span>{desc} {volume}%";
                    format-muted= "<span size='14000' foreground='#EBDDAA'></span> Muted";
                    format-icons= {
                        headphone= " ";
                        hands-free= " ";
                        headset= " ";
                        phone= " ";
                        portable= " ";
                        car= " ";
                        default= [" " " "];
                    };
                };
                backlight= {
                    device= "intel_backlight";
                    format= "{icon} {percent}%";
                    format-icons= [" " " "];
                };
                temperature = {
                    thermal-zone = "1";
                    format = "{temperatureC}°C";
                };
                "custom/weather" = {
                    format = "{}°";
                    tooltip = "true";
                    interval = "3600";
                    exec = "${pkgs.wttrbar}/bin/wttrbar";
                    return-type = "json";
                };

            };
        };
        # https://github.com/Alexays/Waybar/wiki/Styling
        style = ''
            * {
                border-radius: 0;
                font-family: 'Operator Mono SSm Book';
                font-size: 10pt;
                min-height: 0;
            }

            window#waybar {
                background: transparent;
                color: #${config.colorScheme.palette.base05};
            }

            tooltip {
                background: #${config.colorScheme.palette.base00};
                border-radius: 15px;
                border-width: 2px;
                border-style: solid;
                border-color: #${config.colorScheme.palette.base02};
            }

            #workspaces button {
                color: #${config.colorScheme.palette.base05};
                border-radius: 12px;
            }

            #workspaces button.active {
                background: #${config.colorScheme.palette.base02};
            }

            #workspaces button.urgent {
                background: #${config.colorScheme.palette.base08};
            }

            #workspaces button:hover {
                background: #${config.colorScheme.palette.base02};
            }
            
            #workspaces {
            padding: 0px;
            }

            .module {
                background: #${config.colorScheme.palette.base00};
                border-radius: 15px;
                border-style: solid;
                border-width: 2px;
                border-color: #${config.colorScheme.palette.base02};
                padding: 0px 7px;
                margin: 0px 3px;
            }
        '';
    };
}
