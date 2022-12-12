#!/usr/bin/env bash
cd ~/.config/polybar/
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ $(xrandr --listactivemonitors|grep -Po '(?<=Monitors\: )\d') -eq 1 ]]; then
    polybar --reload primary &
fi

if [[ $(xrandr --listactivemonitors|grep -Po '(?<=Monitors\: )\d') -eq 2 ]]; then
    MONITOR=$(xrandr --listactivemonitors|grep -Po '(?<=\+\*)\S*') polybar --reload primary &
    MONITOR=$(xrandr --listactivemonitors|grep -Po '(?<=\:\ \+)[^\*]\S*') polybar --reload secondary &    
fi

if [[ $(xrandr --listactivemonitors|grep -Po '(?<=Monitors\: )\d') -ge 3 ]]; then
    rightmostSecondaryMonitor=$(xrandr --listactivemonitors|grep -P '(?<=\:\ \+)[^\*]\S*'|awk '{split($3,a,"+")} max<a[2]{max=a[2]; mon=$2} END{ print(substr(mon,2))}')
    primaryMonitor=$(xrandr --listactivemonitors|grep -Po '(?<=\+\*)\S*')
    auxArray=$(xrandr --listactivemonitors|grep -P '(?<=\:\ \+)[^\*]\S*'|grep -Ev $rightmostSecondaryMonitor|grep -Po '(?<=\:\ \+)[^\*]\S*')
    MONITOR=$primaryMonitor polybar --reload primary &
    MONITOR=$rightmostSecondaryMonitor polybar --reload secondary &
    while IFS= read -r line; do
        MONITOR=$line polybar --reload auxilary &
    done <<< $auxArray
        
fi
