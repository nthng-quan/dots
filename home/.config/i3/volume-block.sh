#!/bin/bash
. ~/.config/i3/block.sh

case $BLOCK_BUTTON in
    1) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    4) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+ ;;
    5) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%- ;;
    3) pavucontrol & ;;
esac

VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "yes" || echo "no")

if   [ "$MUTED" = "yes" ]; then output "MUTE"    "$C_OVERLAY0"
elif [ "$VOL" -le 30 ];     then output "VOL ${VOL}%" "$C_GREEN"
elif [ "$VOL" -le 65 ];     then output "VOL ${VOL}%" "$C_TEXT"
elif [ "$VOL" -le 90 ];     then output "VOL ${VOL}%" "$C_YELLOW"
else                              output "VOL ${VOL}%" "$C_RED"
fi
