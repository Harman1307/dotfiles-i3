#!/bin/bash

WALLPAPER_DIR="$HOME/wallpapers"

selected=$(sxiv -t -o "$WALLPAPER_DIR")

if [ -n "$selected" ]; then
    wal -i "$selected"
    feh --bg-fill "$selected"
    convert "$selected" -blur 0x8 -fill black -colorize 30% /tmp/lock_screen.png &
fi