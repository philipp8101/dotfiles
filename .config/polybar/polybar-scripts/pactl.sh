#!/usr/bin/env bash
if command -v pulseaudio-control &> /dev/null
then
	case $1 in
		"--rclick" )
			exec myxer &
		;;
		"--lclick" )
			pulseaudio-control togmute
		;;
		"--mclick" )
			pulseaudio-control --node-blacklist "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra2" --node-blacklist "alsa_output.pci-0000_01_00.1.hdmi-stereo" --node-blacklist "alsa_output.pci-0000_00_1f.3.iec958-stereo" --node-blacklist "alsa_output.pci-0000_01_00.1.hdmi-stereo" next-node
		;;
		"--scroll-up" )
			pulseaudio-control --volume-max 130 up
		;;
		"--scroll-down" )
			pulseaudio-control --volume-max 130 down
		;;
		* )
		pulseaudio-control --node-nicknames-from "device.description"  --node-nickname "alsa_output.usb-SteelSeries_Arctis_Pro_Wireless-00.analog-stereo:  Arctis Pro Wireless" --node-nickname "alsa_output.usb-SteelSeries_SteelSeries_Arctis_9_000000000000-00.stereo-game:  Arctis 9 Game" --node-nickname "alsa_output.usb-SteelSeries_SteelSeries_Arctis_9_000000000000-00.stereo-chat:  Arctis 9 Chat" --node-nickname "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1:  HDMI" --node-nickname "alsa_output.pci-0000_00_1f.3.analog-stereo:  Analog Stereo" --node-nickname "jack_out:JACK sink" listen
		;;


	esac
fi
