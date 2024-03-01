#!/usr/bin/env bash
status_file="/tmp/polybar-module-rgb-off"

if [[ $(hostnamectl hostname) != "arch" ]]; then
	exit 0;
fi 

if [[ $1 == "--toggle" ]]; then

	if [[ -e $status_file ]]; then
		# leds are off
		rm $status_file;
		~/.scripts/openrgb.sh --on
	else
		# leds are on
		touch $status_file
		~/.scripts/openrgb.sh --off
	fi 
	exit 0
fi

if [[ -e $status_file ]]; then
	echo 
else
	echo ﯧ
fi 


