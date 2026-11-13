#!/bin/bash
# Media title (Spotify preferred). Click: control menu.
. ~/.config/i3/block.sh

[ -n "$BLOCK_BUTTON" ] && setsid -f ~/.config/i3/media-menu.sh >/dev/null 2>&1

mapfile -t PLAYING < <(playing_order)
if [ ${#PLAYING[@]} -gt 0 ]; then PLAYER=${PLAYING[-1]}; else PLAYER=$(active_players | /usr/bin/head -1); fi
[ -z "$PLAYER" ] && { output "[-]" "$C_OVERLAY0"; exit 0; }
APP=${PLAYER%%.*}
LABEL=$(timeout 2 playerctl -p "$PLAYER" metadata --format '{{title}}' 2>/dev/null)
LABEL=${LABEL:+$APP: $LABEL}   # "spotify: Song", or just the app name when no title
LABEL=${LABEL:-$APP}
OTHERS=""                      # every playing app with its title; latest one last
for p in "${PLAYING[@]}"; do
    [ "$p" = "$PLAYER" ] && continue
    t=$(timeout 2 playerctl -p "$p" metadata --format '{{title}}' 2>/dev/null)
    OTHERS+="${p%%.*}${t:+: $t} · "
done
LABEL="$OTHERS$LABEL"
MAX=${MEDIA_MAX:-40}           # bar text limit; full titles stay in the click menu
[ ${#LABEL} -gt $MAX ] && LABEL="${LABEL:0:MAX-1}…"
LABEL=${LABEL//&/&amp;}; LABEL=${LABEL//</&lt;}; LABEL=${LABEL//>/&gt;}
[ "$(timeout 2 playerctl -p "$PLAYER" status 2>/dev/null)" = "Playing" ] && output "$LABEL" "$C_GREEN" || output "$LABEL" "$C_OVERLAY0"
