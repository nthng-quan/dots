#!/bin/bash
CURRENT=$(powerprofilesctl get)
case "$CURRENT" in
    performance)
        powerprofilesctl set balanced
        notify-send "Power" "Balanced"
        ;;
    balanced)
        powerprofilesctl set power-saver
        notify-send "Power" "Battery Saver"
        ;;
    power-saver)
        powerprofilesctl set performance
        notify-send "Power" "Performance"
        ;;
esac
