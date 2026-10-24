#!/bin/bash
BACKLIGHT=/sys/class/backlight/intel_backlight
MAX=$(cat "$BACKLIGHT/max_brightness" 2>/dev/null)
STEP_PCT=5

pct_of()  { echo $(( $1 * 100 / MAX )); }
val_of()  { echo $(( $1 * MAX / 100 )); }

get_cur() {
    if [ -w "$BACKLIGHT/brightness" ]; then
        cat "$BACKLIGHT/brightness"
    fi
}

set_brightness() {
    local new_pct=$1
    [ $new_pct -gt 100 ] && new_pct=100
    [ $new_pct -lt 5 ]   && new_pct=5

    if [ -w "$BACKLIGHT/brightness" ]; then
        echo $(val_of $new_pct) > "$BACKLIGHT/brightness"
    fi
}

up() {
    cur_pct=$(pct_of $(get_cur))
    new_pct=$(( cur_pct + STEP_PCT ))
    set_brightness $new_pct
    notify-send "Brightness" "$new_pct%" -h int:value:"$new_pct" -h string:synchronous:brightness
}

down() {
    cur_pct=$(pct_of $(get_cur))
    new_pct=$(( cur_pct - STEP_PCT ))
    set_brightness $new_pct
    notify-send "Brightness" "$new_pct%" -h int:value:"$new_pct" -h string:synchronous:brightness
}

case "$1" in
    up)   up ;;
    down) down ;;
    *)    echo "Usage: $0 {up|down}"; exit 1 ;;
esac
