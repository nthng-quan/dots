#!/bin/bash
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

if [ "$BLOCK_BUTTON" = "1" ]; then
    idx=$(gsettings get org.gnome.desktop.input-sources current 2>/dev/null)
    if [[ "$idx" == *"1"* ]]; then
        ibus engine xkb:us::eng 2>/dev/null
    else
        ibus engine Unikey 2>/dev/null
    fi
fi

idx=$(gsettings get org.gnome.desktop.input-sources current 2>/dev/null)
if [[ "$idx" == *"1"* ]]; then
    echo "VN"
    echo "VN"
    echo "#ffffff"
else
    echo "EN"
    echo "EN"
    echo "#555555"
fi
