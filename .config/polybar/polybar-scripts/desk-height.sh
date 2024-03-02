#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo 0
    mosquitto_sub -h 192.168.0.5 -t "desk/current-height" -u mosquitto -P Y3Gnwwo= 2> /dev/null
elif [[ $1 == "up" ]]; then
    mosquitto_pub -h 192.168.0.5 -t "desk/control-height" -u mosquitto -P Y3Gnwwo= -m "up"
elif [[ $1 == "down" ]]; then
    mosquitto_pub -h 192.168.0.5 -t "desk/control-height" -u mosquitto -P Y3Gnwwo= -m "down"
fi
