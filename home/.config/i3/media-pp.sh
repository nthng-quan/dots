#!/bin/bash
. ~/.config/i3/block.sh

[ "$BLOCK_BUTTON" = "1" ] && { timeout 2 playerctl play-pause 2>/dev/null; refresh_media; sleep 0.3; }

ACTIVE=$(timeout 2 playerctl -a status 2>/dev/null | grep -c "Playing")
if [ "$ACTIVE" -gt 0 ]; then
    output "[>]" "$C_GREEN"
else
    output "[-]" "$C_OVERLAY0"
fi
