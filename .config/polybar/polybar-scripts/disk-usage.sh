#!/usr/bin/env bash
#file=/tmp/polybar-disk-counter #if  [ -z $file ] || [ -e $file ]; then
	#counter=$(cat $file);
#else
	#counter=0;
#fi
#case $counter in
	#0)
		#root=$(df / --output=avail -h | tr -d ' ' | tail -n 1)
		#echo "%{F#6e738d}/%{F-}: $root"
		#;;
	#1)
		#data=$(df /data --output=avail -h | tr -d ' ' | tail -n 1)
		#echo "%{F#6e738d}HDD%{F-}: $HDD "
		#;;
	#2)
		#games=$(df /games --output=avail -h | tr -d ' ' | tail -n 1)
		#echo "%{F#6e738d}HDD2%{F-}: $HDD2"
		##;;
##esac
#out=$(expr \( $counter + 1 \) % 3)
#echo $out > $file
#echo "%{F#6e738d}/%{F-}: $root %{F#6e738d}/data%{F-}: $data %{F#6e738d}/games%{F-}: $games"
a=$(sudo zpool status |awk '{if($1 ~ /tank/){print $2}}')
b=$(sudo zpool iostat | awk '{if($1 ~ /tank/){print "%{F#6e738d}free:%{F-}" $3 }}') #" %{F#6e738d}read:%{F-}" $6 " %{F#6e738d}write:%{F-}" $7 }}')
if [[ $a -eq "ONLINE" ]] ; then
	echo -n "%{F#6e738d}status:%{F-}"$a $b;
else
	if [[ $(expr $(date +%s) % 2) -eq 0 ]] ; then
		echo -n "%{F#6e738d}status:%{F-}%{F#f50a81}"$a"%{F-}" $b;
	else
		echo -n "%{F#6e738d}status:%{F-}"$a $b;
	fi
fi
relsec=$(echo /dev/disk/by-id/{ata-ST4000VN008-2DR166_ZDHAFGH2,ata-WDC_WD40EFZX-68AWUN0_WD-WXB2D714HDPE,ata-WDC_WD40EFZX-68AWUN0_WD-WXB2D71HZSVU,ata-ST4000VN008-2DR166_ZDHAGDKA} |xargs -n 1 sudo smartctl -a|grep Reallocated_Sector_Ct |awk '{a += $10} END{print a}')
if [[ $relsec -ne 0 ]]; then
    echo " %{F#f50a81}relsec:%{F-}"$relsec
fi
