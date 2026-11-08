#!/bin/sh
# Cycle wallpapers in ~/Pictures/wallpapers/ocean.
#   wallpaper-cycle.sh        loop forever, switching every $INTERVAL seconds
#   wallpaper-cycle.sh next   switch once (bound to $mod+Ctrl+n)
DIR=${WALLPAPER_DIR:-$HOME/Pictures/wallpapers/ocean}
INTERVAL=${WALLPAPER_INTERVAL:-900}
STATE=${XDG_RUNTIME_DIR:-/tmp}/wallpaper-cycle.idx

next() {
	set -- "$DIR"/*.jpg "$DIR"/*.png
	files=""; n=0
	for f; do [ -f "$f" ] && { files="$files
$f"; n=$((n + 1)); }; done
	[ "$n" -eq 0 ] && return
	i=$(( ($(cat "$STATE" 2>/dev/null || echo -1) + 1) % n ))
	echo "$i" >"$STATE"
	feh --no-fehbg --bg-fill "$(printf '%s\n' "$files" | sed -n "$((i + 2))p")"
}

if [ "$1" = next ]; then next; exit; fi

# single instance: replace an older loop on i3 restart
for p in $(pgrep -f "wallpaper-cycle.sh$"); do [ "$p" != $$ ] && kill "$p" 2>/dev/null; done
while :; do next; sleep "$INTERVAL"; done
