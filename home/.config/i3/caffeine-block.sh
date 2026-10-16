#!/bin/bash
. ~/.config/i3/block.sh

STATE_FILE=/tmp/caffeine_state

if [ "$BLOCK_BUTTON" = "1" ]; then
    if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "ON" ]; then
        xset s on +dpms
        echo "OFF" > "$STATE_FILE"
    else
        xset s off -dpms
        echo "ON" > "$STATE_FILE"
    fi
fi

if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "ON" ]; then
    output "CAF"    "$C_RED"
else
    output "DECAF"  "$C_SURFACE2"
fi
