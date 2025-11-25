#!/bin/bash

WALLPAPER_DIR=~/wallpapers
CURRENT_WALLPAPER=$(cat ~/.cache/wal/wal 2>/dev/null)

wallpapers=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | grep -v "$(basename "$CURRENT_WALLPAPER")"))

if [ ${#wallpapers[@]} -eq 0 ]; then
    wallpapers=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \)))
fi

wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

if [ -n "$wallpaper" ]; then
    wal -i "$wallpaper" -n
    xrdb -merge ~/.Xresources
    feh --bg-fill "$wallpaper"
    
    killall polybar
    sleep 0.3
    ~/.config/polybar/launch.sh &
    
    pkill -f lock-prep.sh
    ~/.config/i3/lock-prep.sh &
    
    notify-send "Random Wallpaper" "$(basename "$wallpaper")"
fi