#!/bin/bash
. ~/.config/i3/block.sh

CAP=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

[ -z "$CAP" ] && exit 0

if   [ "$STATUS" = "Charging" ]; then icon="+ "; c="$C_GREEN"
elif [ "$STATUS" = "Full" ];     then icon="";    c="$C_GREEN"
elif [ "$CAP" -le 15 ];          then icon="";    c="$C_RED"
elif [ "$CAP" -le 30 ];          then icon="";    c="$C_PEACH"
else                                  icon="";    c="$C_SUBTEXT0"
fi

output "BAT: ${icon}${CAP}%" "$c"
