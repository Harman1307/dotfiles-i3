#!/bin/bash
status=$(playerctl status 2>/dev/null)
if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
    title=$(playerctl metadata title 2>/dev/null | sed 's/ - YouTube.*//g; s/ - Topic//g')
    [ "$status" = "Playing" ] && icon="󰏤" || icon="󰐊"
    [ -n "$title" ] && echo "󰎈 ${title:0:35} $icon"
else
    echo ""
fi
