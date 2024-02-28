#!/usr/bin/env bash
b=$(timeout 1m headsetcontrol -cb 2> /dev/null)
m=$(timeout 1m headsetcontrol -cm 2> /dev/null)
timeout 1m headsetcontrol -cb 2>&1 | grep -qP '[a-zA-Z]+' && exit 0
timeout 1m headsetcontrol -cm 2>&1 | grep -qP '[a-zA-Z]+' && exit 0
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
	echo "   -"$(expr 100 - $(expr $m \* 100 / 64))"%"
fi
if [[ $m -gt 64 ]] ; then
	echo "   -"$(expr $(expr $m - 64) \* 100 / 64)"%"
fi

