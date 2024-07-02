#!/usr/bin/env bash
b=$(timeout 1m headsetcontrol -o JSON |jq ".devices[0].battery.level")
m=$(timeout 1m headsetcontrol -o JSON |jq ".devices[0].chatmix")
if [[ $b -ge 75 ]] ; then
	echo -n " "$b"% "
elif [[ $b -ge 50 ]] ; then
	echo -n " "$b"% "
elif [[ $b -ge 25 ]] ; then
	echo -n " "$b"% "
elif [[ $b -eq -1 ]] ; then
	echo -n "Charging "
else
	echo -n " "$b"% "
fi
if [[ $m -lt 64 ]] ; then
	echo "  󰋎 -"$(expr 100 - $(expr $m \* 100 / 64))"%"
fi
if [[ $m -gt 64 ]] ; then
	echo "   -"$(expr $(expr $m - 64) \* 100 / 64)"%"
fi

