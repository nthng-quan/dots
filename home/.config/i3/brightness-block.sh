#!/bin/bash
. ~/.config/i3/block.sh

BACKLIGHT=/sys/class/backlight/intel_backlight

get_pct() {
    if [ -w "$BACKLIGHT/brightness" ]; then
        MAX=$(cat "$BACKLIGHT/max_brightness" 2>/dev/null)
        CUR=$(cat "$BACKLIGHT/brightness" 2>/dev/null)
        [ -n "$MAX" ] && [ -n "$CUR" ] && echo $(( CUR * 100 / MAX )) && return
    fi
    BR=$(xrandr --verbose 2>/dev/null | awk '/Brightness/ {print $2; exit}')
    [ -n "$BR" ] && echo "$BR * 100" | bc -l | cut -d. -f1 && return
    echo "?"
}

set_pct() {
    local pct=$1
    [ "$pct" -gt 100 ] && pct=100
    [ "$pct" -lt 5 ]   && pct=5
    if [ -w "$BACKLIGHT/brightness" ]; then
        MAX=$(cat "$BACKLIGHT/max_brightness")
        echo $(( pct * MAX / 100 )) > "$BACKLIGHT/brightness"
    else
        val=$(echo "scale=2; $pct / 100" | bc -l)
        xrandr --output eDP-1 --brightness "$val" 2>/dev/null
    fi
}

case $BLOCK_BUTTON in
    4) set_pct $(( $(get_pct) + 5 )) ;;
    5) set_pct $(( $(get_pct) - 5 )) ;;
esac

output "BRT $(get_pct)%" "$C_SUBTEXT0"
