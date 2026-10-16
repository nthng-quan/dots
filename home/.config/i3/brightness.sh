#!/usr/bin/env bash
set -euo pipefail
case "${1:-}" in
  up) brightnessctl set +5% ;;
  down) brightnessctl set 5%- ;;
  *) echo "Usage: $0 {up|down}" >&2; exit 2 ;;
esac
