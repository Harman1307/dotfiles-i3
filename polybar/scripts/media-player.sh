#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null | sed 's/ - YouTube.*//g; s/ - Topic//g')
    
    if [ "$status" = "Playing" ]; then
        icon="󰐊"
    else
        icon="󰏤"
    fi
    
    if [ -n "$artist" ] && [ "$artist" != " " ]; then
        output="$artist - $title"
    else
        output="$title"
    fi
    
    # Limit length
    if [ ${#output} -gt 40 ]; then
        output="${output:0:37}..."
    fi
    
    echo "󰎈 $output $icon"
else
    echo ""
fi
