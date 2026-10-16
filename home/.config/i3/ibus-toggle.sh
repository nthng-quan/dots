#!/bin/bash
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

idx=$(gsettings get org.gnome.desktop.input-sources current 2>/dev/null)
if [[ "$idx" == *"1"* ]]; then
    ibus engine xkb:us::eng 2>/dev/null
    notify-send "Input" "English"
else
    ibus engine Unikey 2>/dev/null
    notify-send "Input" "Tiếng Việt (Unikey)"
fi
