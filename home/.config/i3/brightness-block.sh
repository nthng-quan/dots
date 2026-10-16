#!/usr/bin/env bash
. ~/.config/i3/block.sh
case "${BLOCK_BUTTON:-}" in
  4) brightnessctl set +5% >/dev/null ;;
  5) brightnessctl set 5%- >/dev/null ;;
esac
pct=$(brightnessctl -m 2>/dev/null | cut -d, -f4)
output "BRT ${pct:-?}" "$C_SUBTEXT0"
