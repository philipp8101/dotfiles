#!/bin/bash
case $1 in
	"--on" )
		openrgb -d 1 -m "Rainbow Wave" -d 2 -m "Rainbow Wave" -d 4 -m "Rainbow" > /dev/null
		;;
	"--off" )
		openrgb -d 1 -m "Direct" -d 2 -m "Direct" -d 4 -m "Direct" > /dev/null
		;;

esac
