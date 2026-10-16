#!/bin/bash
case $BLOCK_BUTTON in
    1) nm-connection-editor & ;;
    3) alacritty -e nmtui & ;;
esac

SSID=$(nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | grep "^yes:" | cut -d: -f2)
CONN=$(nmcli -t -f NAME connection show --active 2>/dev/null | head -1)

if [ -n "$SSID" ]; then
    echo "$SSID"
    echo "$SSID"
    echo "#a6e3a1"
elif [ -n "$CONN" ]; then
    echo "$CONN"
    echo "$CONN"
    echo "#89b4fa"
else
    echo "OFF"
    echo "OFF"
    echo "#6c7086"
fi
