#!/bin/bash
# Bar button for an external monitor (hidden when none is connected).
#   left click   swap: external only <-> laptop only
#   right click  both: external primary, laptop secondary (to its right)
. ~/.config/i3/block.sh

ext=$(xrandr --query | awk '/ connected/ && $1 != "eDP-1" {print $1; exit}')
[ -z "$ext" ] && exit 0
name=${ext%-*}

active=$(xrandr --listactivemonitors)
lap=0; ex=0
[[ $active == *" eDP-1"* ]] && lap=1
[[ $active == *" $ext"* ]] && ex=1

# external's top (first-listed) resolution at its highest refresh rate
ext_on() {
    read -r mode rate < <(xrandr --query | awk -v o="$ext" '
        $1 == o {f = 1; next}
        f && /^ / {m = $1; r = 0; for (i = 2; i <= NF; i++) {v = $i; gsub(/[*+]/, "", v); if (v + 0 > r) r = v + 0}; print m, r; exit}')
    echo --output "$ext" --mode "$mode" --rate "$rate" --primary
}
ext_only()    { xrandr $(ext_on) --output eDP-1 --off && lap=0 ex=1; }
both()        { xrandr $(ext_on) --output eDP-1 --auto --right-of "$ext" && lap=1 ex=1; }
laptop_only() { xrandr --output eDP-1 --auto --primary --output "$ext" --off && lap=1 ex=0; }

case $BLOCK_BUTTON in
    1) if [ $ex = 1 ] && [ $lap = 0 ]; then laptop_only; else ext_only; fi ;;
    3) both ;;
esac

# active screens lit, inactive dimmed; primary listed first
lit() { echo "<span foreground='#$C_MAUVE'>$1</span>"; }
dim() { echo "<span foreground='#$C_OVERLAY0'>$1</span>"; }
[ $ex = 1 ] && E=$(lit "$name") || E=$(dim "$name")
[ $lap = 1 ] && L=$(lit "eDP")   || L=$(dim "eDP")
if [ $ex = 1 ]; then output "$E $(dim -) $L"
else                 output "$L $(dim -) $E"
fi
