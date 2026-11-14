#!/bin/bash
# HCMUS graduate-office notices (~/tools/sdh-reader). Shows `Mst +N` unread,
# pops a notification for each newly published notice. Click: open the reader.
. ~/.config/i3/block.sh

READER=~/tools/sdh-reader/sdh_reader.py
NOTIFIED=~/.cache/sdh-notified   # ids already announced, so each notice pops once
[ -x "$READER" ] || exit 0

if [ "$BLOCK_BUTTON" = 1 ]; then
    # refresh the count (signal 13) once the reader closes, i.e. after reading
    setsid -f kitty --class sdh-reader -e sh -c "$READER; pkill -SIGRTMIN+13 i3blocks" >/dev/null 2>&1
fi

out=$(timeout 30 "$READER" --count 2>/dev/null) || { output "Mst ?" "$C_OVERLAY0"; exit 0; }
n=$(head -1 <<<"$out")

mkdir -p ~/.cache
if [ -f "$NOTIFIED" ]; then
    while IFS=$'\t' read -r id title; do
        grep -qx "$id" "$NOTIFIED" && continue
        notify-send -a "Mst HCMUS" "Mst: new notice" "$title"
        echo "$id" >>"$NOTIFIED"
    done < <(tail -n +2 <<<"$out")
else
    tail -n +2 <<<"$out" | cut -f1 >"$NOTIFIED"   # first run: remember, don't spam
fi

# reminder every $MST_REMIND seconds (default 2 h) while anything is unread
REMIND=${MST_REMIND:-7200} LAST=~/.cache/sdh-reminded
if [ "$n" -gt 0 ] && [ $(( $(date +%s) - $(stat -c %Y "$LAST" 2>/dev/null || echo 0) )) -ge "$REMIND" ]; then
    latest=$(sed -n 2p <<<"$out" | cut -f2)
    notify-send -a "Mst HCMUS" "Mst: $n unread" "Latest: $latest
Click Mst on the bar to read."
    touch "$LAST"
fi

if [ "$n" -gt 0 ]; then output "Mst +$n" "$C_YELLOW"
else                    output "Mst"     "$C_OVERLAY0"
fi
