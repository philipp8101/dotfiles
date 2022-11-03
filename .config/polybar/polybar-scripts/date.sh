#!/bin/bash

 
case "$1" in
--popup)
	yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons --posx=815 --posy=125        --title="calendar" --borders=0
    ;;
--tz)
	notify-send "$(TZ=$(i3-input|grep -Po '(?<=output = ).+') date "+%Z - %a - KW%V - %d.%m.%Y %H:%M")"
	;;
*)
	#date "+UTC%:::z(%Z) - %a - KW%V - %d.%m.%Y %H:%M"
	date "+%Z - %a - KW%V - %d.%m.%Y %H:%M"
    ;;
esac
 
