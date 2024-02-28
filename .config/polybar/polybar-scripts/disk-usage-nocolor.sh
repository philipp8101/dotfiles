#!/usr/bin/env bash
#file=/tmp/polybar-disk-counter
#if  [ -z $file ] || [ -e $file ]; then
	#counter=$(cat $file);
#else
	#counter=0;
#fi
#case $counter in
	#0)
		#root=$(df / --output=avail -h | tr -d ' ' | tail -n 1)
		#echo "%{F#0a81f5}/%{F-}: $root"
		#;;
	#1)
		#data=$(df /data --output=avail -h | tr -d ' ' | tail -n 1)
		#echo "%{F#0a81f5}HDD%{F-}: $HDD "
		#;;
	#2)
		#games=$(df /games --output=avail -h | tr -d ' ' | tail -n 1)
		#echo "%{F#0a81f5}HDD2%{F-}: $HDD2"
		##;;
##esac
#out=$(expr \( $counter + 1 \) % 3)
#echo $out > $file
#echo "%{F#0a81f5}/%{F-}: $root %{F#0a81f5}/data%{F-}: $data %{F#0a81f5}/games%{F-}: $games"
a=$(zpool status |awk '{if($1 ~ /tank/){print $2}}')
b=$(zpool iostat | awk '{if($1 ~ /tank/){print "free:" $3 }}') #" %{F#0a81f5}read:%{F-}" $6 " %{F#0a81f5}write:%{F-}" $7 }}')
if [[ $a -eq "ONLINE" ]] ; then
	echo "status:"$a $b;
else
	if [[ $(expr $(date +%s) % 2) -eq 0 ]] ; then
		echo "status:"$a $b;
	else
		echo "status:"$a $b;
	fi
fi
