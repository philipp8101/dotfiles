#!/bin/sh

STATUS=$(expressvpn status 2>&1 | grep -E 'Not\ connected')
if [ "$STATUS" == '' ]; then
	STATUS=$(expressvpn status 2>&1 | grep -E 'Connected to')
fi

#STATUS=$(expressvpn status 2>&1 )
#tmp=$(expressvpn status 2>&1 |grep -v 'new version')
#if [[ $? -eq 0 ]]; then
	#STATUS=$(expressvpn status 2>&1 |sed '1,2d')
#fi

expressvpn_toggle() {
    if [ "$STATUS" != 'Not connected' ]; then
        ~/.scripts/vpn_off.sh
    else
        ~/.scripts/vpn_on.sh
    fi
}

expressvpn_status() {
    if [ "$STATUS" != 'Not connected' ]; then
	out=$(echo $STATUS| head -n1 |grep -E 'Connected to' |grep -Po "(?<=Connected to ).*")
        echo -e '' $out
    else
        echo -e ' VPN'
    fi
}

case "$1" in
    --toggle)
        expressvpn_toggle
    ;;
    *)
        expressvpn_status
    ;;
esac
