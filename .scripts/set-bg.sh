#!/bin/bash
if [[ $(hostnamectl hostname) == "arch" ]]; then 
	feh --no-fehbg --bg-fill  /home/philipp/Pictures/landscape1 --bg-fill  /home/philipp/Pictures/landscape2 --bg-fill /home/philipp/Pictures/portrait1 
else
	feh --no-fehbg --bg-fill ~/.config/i3/background.png
fi
