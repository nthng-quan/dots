#!/bin/bash
. ~/.config/i3/block.sh

case $BLOCK_BUTTON in
    1) wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle ;;
    4) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+ ;;
    5) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%- ;;
    3) pavucontrol -t 4 & ;;
esac

STATE=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
VOL=$(awk '{print int($2*100)}' <<<"$STATE")

if [[ $STATE == *MUTED* ]]; then output "MIC OFF"     "$C_RED"
else                             output "MIC ${VOL}%" "$C_GREEN"
fi
