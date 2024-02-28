#!/usr/bin/env bash
l=$(checkupdates | grep -E '^linux ') || exit 1
z=$(checkupdates | grep -E '^zfs-linux ') || exit 1

echo $z | grep -qo $(echo $l | grep -oP '(?<=-> ).*' |grep -oP '[\d\.]*arch[\d\.\-]*') && echo "" || echo ""
