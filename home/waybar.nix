{ ... }:
{
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
            mainBar = {
                layer= "top";
                position= "top";
                modules-left= ["wlr/workspaces"];
                modules-center= ["clock"];
                modules-right= ["cpu" "memory" "network" "pulseaudio" "backlight" "battery" "tray"];
                tray= {
                    icon-size= 21;
                    spacing= 10;
                };
                "wlr/workspaces"= {
                    on-click= "activate";
                    on-scroll-up= "hyprctl dispatch workspace m-1";
                    on-scroll-down= "hyprctl dispatch workspace m+1";
                };
                clock= {
                    format= "<span foreground='#C6AAE8'> </span>{:KW%V %a %d %H:%M}";
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
                    format-icons= ["" "" "" "" ""];
                    tooltip-format= "{time}";
                };
                cpu= {
                    interval= 1;
                    format= "{}%";
                    max-length= 10;
                };
                memory= {
                    interval= 1;
                    format= "{}%";
                    max-length= 10;
                };
                network= {
                    format-wifi= "<span size='13000' foreground='#F2CECF'> </span>{essid}";
                    format-ethernet= "<span size='13000' foreground='#F2CECF'>󱊪 </span>{ipaddr}";
                    format-linked= "{ifname} (No IP) ";
                    format-disconnected= "<span size='13000' foreground='#F2CECF'> </span>Disconnected";
                    tooltip-format-wifi= "Signal Strenght: {signalStrength}%";
                };
                pulseaudio= {
                    on-click= "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                    format= "<span size='13000' foreground='#EBDDAA'>{icon}</span> {volume}%";
                    format-muted= "<span size='14000' foreground='#EBDDAA'></span> Muted";
                    format-icons= {
                        headphone= "";
                        hands-free= "";
                        headset= "";
                        phone= "";
                        portable= "";
                        car= "";
                        default= ["" ""];
                    };
                };
                backlight= {
                    device= "intel_backlight";
                    format= "{icon} {percent}%";
                    format-icons= ["" ""];
                };

            };
        };
        style = ''
            * {
                border-radius: 0;
                font-family: 'Operator Mono SSm Book';
                font-size: 10pt;
                min-height: 0;
            }

            window#waybar {
                background: #1E1E28;
                color: #DADAE8;
            }

            tooltip {
                    background: #1E1E28;
                    border-radius: 15px;
                    border-width: 2px;
                    border-style: solid;
                    border-color: #a4b9ef;
                    }

            #workspaces {
                background: #332E41;
                margin-top: 2px;
                margin-bottom: 2px;
                border-radius: 0px 15px 15px 0px;
            }

            #workspaces button {
                padding-left: 10px;
                padding-right: 10px;
                min-width: 0;
                color: #DADAE8;
            }

            #workspaces button.active {
                color: #A4B9EF;
                border-color: #A4B9EF;
                border-style: solid none none none;
                border-width: 2px;
            }

            #workspaces button.urgent {
                color: #F9C096;
                border-color: #F9C096;
                border-style: solid none none none;
                border-width: 2px;
            }

            #workspaces button:hover {
                background: #332e41;
                border-color: #332e41;
                    color: #A4B9EF;
            }

            #tray, #network, #cpu, #memory, #battery, #pulseaudio, #workspaces, #mpd, #backlight  {
                    padding-left: 8px;
                    padding-right: 8px;
                background: #332E41;
                margin-top: 2px;
                margin-bottom: 2px;
            }

            #cpu {
                padding-left: 15px;
                padding-right: 2px;
                background: #332E41;
                border-radius: 15px 0px 0px 15px;
                margin-top: 2px;
                margin-bottom: 2px;
            }

            #custom-vpn {
                background: #332E41;
                padding-right: 10px;
                margin-top: 2px;
                margin-bottom: 2px;
            }

            /* #pulseaudio { */
            /*     padding-right: 15px; */
            /*     margin-right: 5px; */
            /*     border-radius: 0px 15px 15px 0px; */
            /* } */

            #clock, #custom-spotify {
                background: #332E41;
                margin-top: 2px;
                margin-bottom: 2px;
                padding-right: 15px;
                padding-left: 15px;
                border-radius: 15px;
            }
        '';
    };
}
