#!/bin/bash
STATE_FILE=/tmp/caffeine_state

case "$1" in
    on)
        xset s off -dpms
        echo "ON" > "$STATE_FILE"
        ;;
    off)
        xset s on +dpms
        echo "OFF" > "$STATE_FILE"
        ;;
    toggle)
        if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "ON" ]; then
            $0 off
        else
            $0 on
        fi
        ;;
    status)
        cat "$STATE_FILE" 2>/dev/null || echo "OFF"
        ;;
    *)
        echo "Usage: $0 {on|off|toggle|status}"
        ;;
esac
