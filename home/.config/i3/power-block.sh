#!/bin/bash
. ~/.config/i3/block.sh

case "$BLOCK_BUTTON" in
    1) ~/.config/i3/power-toggle.sh ;;
esac

PROFILE=$(powerprofilesctl get 2>/dev/null)
case "$PROFILE" in
    "power-saver")   output "PWR"  "$C_GREEN"   ;;
    "balanced")      output "BAL"  "$C_YELLOW"  ;;
    "performance")   output "PERF" "$C_RED"     ;;
    *)               output "$PROFILE" "$C_OVERLAY0" ;;
esac
