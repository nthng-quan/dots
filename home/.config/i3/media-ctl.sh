#!/bin/bash
# Media button for the shown player. Usage: media-ctl.sh prev|pp|next
. ~/.config/i3/block.sh

PLAYER=$(pick_player)
[ -z "$PLAYER" ] && exit 0     # hidden when nothing to control
case "$1" in
    prev) CMD=previous; ICON="⏮" ;;
    next) CMD=next;     ICON="⏭" ;;
    pp)   CMD=play-pause ;;
esac
[ "$BLOCK_BUTTON" = "1" ] && { timeout 2 playerctl -p "$PLAYER" $CMD 2>/dev/null; sleep 0.3; refresh_media; }
if [ "$1" = pp ]; then
    if [ "$(timeout 2 playerctl -p "$PLAYER" status 2>/dev/null)" = "Playing" ]; then
        output "⏸" "$C_GREEN"
    else
        output "▶" "$C_YELLOW"
    fi
    exit 0
fi
output "$ICON" "$C_OVERLAY1"
