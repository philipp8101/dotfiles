
#!/bin/sh

expressvpn_toggle() {
    if nmcli con show --active|grep 'my_expressvpn_netherlands_-_amsterdam_udp' -q; then
        nmcli con down id my_expressvpn_netherlands_-_amsterdam_udp
    else
        nmcli con up id my_expressvpn_netherlands_-_amsterdam_udp
    fi
}

expressvpn_status() {
    if nmcli con show --active|grep 'my_expressvpn_netherlands_-_amsterdam_udp' -q; then
        echo -e ' VPN connected'
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
