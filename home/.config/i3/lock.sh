#!/bin/bash
playerctl -a pause 2>/dev/null
wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 2>/dev/null
exec i3lock -f -c 1e1e2e
