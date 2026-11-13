#!/bin/bash
# Rofi menu: one section per media player (Spotify first), pick an action.
. ~/.config/i3/block.sh

short() {   # full title, unmodified
    local t
    t=$1
    printf '%s' "$t"
}

mapfile -t PLAYERS < <(active_players | sort -t. -k1,1 | awk '/^spotify/{print; next} {rest[++n]=$0} END{for(i=1;i<=n;i++) print rest[i]}')
[ ${#PLAYERS[@]} -eq 0 ] && { notify-send "Media" "No player running"; exit 0; }

MENU=""
for p in "${PLAYERS[@]}"; do
    app=${p%%.*}
    st=$(timeout 2 playerctl -p "$p" status 2>/dev/null)
    title=$(short "$(timeout 2 playerctl -p "$p" metadata --format '{{title}}' 2>/dev/null)")
    [ "$st" = "Playing" ] && pp="⏸ Pause" || pp="▶ Play"
    head="$app${title:+ — $title}"
    MENU+="$head: $pp\n$head: ⏭ Next\n$head: ⏮ Previous\n"
    [ "$app" = "spotify" ] && MENU+="$head: ⧉ Focus window\n"
done

CHOICE=$(printf "$MENU" | rofi -dmenu -i -p "media" -no-custom) || exit 0
HEAD=${CHOICE%%:*}
for p in "${PLAYERS[@]}"; do
    app=${p%%.*}
    title=$(short "$(timeout 2 playerctl -p "$p" metadata --format '{{title}}' 2>/dev/null)")
    [ "$app${title:+ — $title}" = "$HEAD" ] || continue
    case "$CHOICE" in
        *Pause|*Play) playerctl -p "$p" play-pause ;;
        *Next)        playerctl -p "$p" next ;;
        *Previous)    playerctl -p "$p" previous ;;
        *Focus*)      i3-msg -q '[class="Spotify"] focus' ;;
    esac
    break
done
sleep 0.3; refresh_media
