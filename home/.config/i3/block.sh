# Helper for i3blocks scripts
# Source: . ~/.config/i3/block.sh
# Then use: output "text" "color"

. ~/.config/i3/colors.sh 2>/dev/null

output() {
    local text="$1"
    local color="${2:-$_SUB}"

    echo "$text"
    echo "$text"
    echo "#$color"
}

# Refreshes all blocks listening on signal 11 (used by media buttons)
refresh_media() {
    pkill -SIGRTMIN+11 i3blocks 2>/dev/null
}

# Signal volume block to refresh
refresh_volume() {
    pkill -SIGRTMIN+10 i3blocks 2>/dev/null
}

# Media players that actually have something loaded (drops idle browser registrations)
active_players() {
    local p
    for p in $(timeout 2 playerctl -l 2>/dev/null); do
        [ "$(timeout 2 playerctl -p "$p" status 2>/dev/null)" = "Stopped" ] && \
            ! timeout 2 playerctl -p "$p" metadata title >/dev/null 2>&1 && continue
        echo "$p"
    done
}

# Playing players, oldest first, latest-started last. Order is remembered in a cache
# file across polls: a player that starts playing is appended to the end.
playing_order() {
    local f=~/.cache/media-playing p now=() kept=()
    for p in $(active_players); do
        [ "$(timeout 2 playerctl -p "$p" status 2>/dev/null)" = "Playing" ] && now+=("$p")
    done
    if [ -f "$f" ]; then
        while read -r p; do [[ " ${now[*]} " == *" $p "* ]] && kept+=("$p"); done < "$f"
    fi
    for p in "${now[@]}"; do [[ " ${kept[*]} " == *" $p "* ]] || kept+=("$p"); done
    mkdir -p ~/.cache; printf '%s\n' "${kept[@]}" > "$f"
    [ ${#kept[@]} -gt 0 ] && printf '%s\n' "${kept[@]}"
}

# Player the bar shows/controls: latest-started playing one, else first active one
pick_player() {
    local p
    p=$(playing_order | /usr/bin/tail -1)
    [ -n "$p" ] && { echo "$p"; return; }
    active_players | /usr/bin/head -1
}
