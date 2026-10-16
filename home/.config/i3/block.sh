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
