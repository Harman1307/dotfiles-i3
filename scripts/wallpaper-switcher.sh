#!/bin/bash

WALLPAPER_DIR=~/wallpapers

wallpapers=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort))

if [ ${#wallpapers[@]} -eq 0 ]; then
    notify-send "No wallpapers found"
    exit 1
fi

# sxiv thumbnail grid: m to mark, q to confirm
chosen=$(sxiv -t -o "${wallpapers[@]}" 2>/dev/null)

if [ -n "$chosen" ]; then
    wal -i "$chosen" -n &
    feh --bg-fill "$chosen"
    
    killall polybar
    sleep 0.5
    ~/.config/polybar/launch.sh &
    
    pkill -f lock-prep.sh
    ~/.config/i3/lock-prep.sh &
    
    notify-send "Wallpaper Changed" "$(basename "$chosen")"
fi
