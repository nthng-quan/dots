#!/bin/sh
# Monitor hotplug watcher: when external monitors are unplugged, turn the
# laptop panel back on (an arandr layout may have switched it off).
# Polls /sys (no sudo/udev needed). Started by i3 exec_always.

for p in $(pgrep -f "monitor-watch.sh$"); do [ "$p" != $$ ] && kill "$p" 2>/dev/null; done

externals() { grep -l '^connected' /sys/class/drm/card*-*/status 2>/dev/null | grep -v eDP | sort; }

prev=$(externals)
while sleep 2; do
	cur=$(externals)
	[ "$cur" = "$prev" ] && continue
	if [ -z "$cur" ]; then
		# all externals gone: laptop panel on, dead outputs off
		xrandr --auto && xrandr --output eDP-1 --auto --primary
		notify-send "Display" "External monitor unplugged — laptop screen restored"
	fi
	prev=$cur
done
