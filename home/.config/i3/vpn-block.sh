#!/bin/bash
. ~/.config/i3/block.sh
if command -v vvpn >/dev/null 2>&1; then
    STATUS=$(vvpn status 2>&1)
    if [[ "$STATUS" == *"Client connected"* ]]; then
        output "VPN" "$C_GREEN"
    else
        output "VPN OFF" "$C_OVERLAY0"
    fi
else
    output "" "$C_OVERLAY0"
fi
