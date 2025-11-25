#!/bin/bash
WALLPAPER_DIR=~/wallpapers
wallpapers=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) | sort))

[ ${#wallpapers[@]} -eq 0 ] && { notify-send "No wallpapers found"; exit 1; }

notify-send "Wallpaper Switcher" "Script started!"

chosen=$(sxiv -t -o "${wallpapers[@]}")

[ -n "$chosen" ] && {
    wal -i "$chosen" -n
    xrdb -merge ~/.Xresources
    feh --bg-fill "$chosen"
    killall polybar; sleep 0.3; ~/.config/polybar/launch.sh &
    pkill -f lock-prep.sh; ~/.config/i3/lock-prep.sh &
    notify-send "Wallpaper changed" "$(basename "$chosen")"
}