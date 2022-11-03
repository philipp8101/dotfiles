#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


MONITOR=DP-2 polybar --reload main &
MONITOR=DP-0 polybar --reload left &
MONITOR=HDMI-0 polybar --reload right &
