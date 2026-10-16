#!/bin/bash
. ~/.config/i3/block.sh

[ "$BLOCK_BUTTON" = "1" ] && { timeout 2 playerctl previous 2>/dev/null; refresh_media; }
output "-Prv" "$C_OVERLAY1"
