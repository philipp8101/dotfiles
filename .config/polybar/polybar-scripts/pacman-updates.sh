#!/bin/bash
ago=$(grep '\[PACMAN\] starting full system upgrade' /var/log/pacman.log |\
	tail -n 1 |\
	grep -E "\[[^P]+\]" -o  |\
	tr -d '[]' |\
       	xargs -I{} date -d {} +%s  |\
       	xargs -I{} expr $(date +%s) - {})
update=$(checkupdates | wc -l)
#if [[ $update -eq 0 ]]; then
	#echo "no updates available"
	#exit 0;
#elif [[ $update -eq 1 ]]; then
	#update=$update" update"
#else
	#update=$update" updates"
#fi
echo $update"  in "$(~/.scripts/timeElapsed.sh $ago) $(~/.config/polybar/polybar-scripts/pacman-check-zfs.sh)
