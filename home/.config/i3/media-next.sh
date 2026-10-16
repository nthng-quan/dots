#!/bin/bash
. ~/.config/i3/block.sh

[ "$BLOCK_BUTTON" = "1" ] && { timeout 2 playerctl next 2>/dev/null; refresh_media; }
output "Nxt+" "$C_OVERLAY1"
