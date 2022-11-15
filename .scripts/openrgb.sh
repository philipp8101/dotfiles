#!/bin/bash
case $1 in
	"--on" )
		openrgb -d 0 -m "Rainbow Wave" -d 1 -m "Rainbow Wave" -d 3 -m "Rainbow" > /dev/null
		;;
	"--off" )
		openrgb -d 0 -m "Direct" -d 1 -m "Direct" -d 3 -m "Direct" > /dev/null
		;;

esac
