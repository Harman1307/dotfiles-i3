#!/bin/bash

WALL_DIR="$HOME/wallpapers"
CURRENT_WALL=$(readlink -f "$HOME/wallpapers/current.jpg")

if [ -z "$@" ]; then
    find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -print0 | sort -z | while IFS= read -r -d '' file; do
        filename=$(basename "$file")
        if [ "$file" = "$CURRENT_WALL" ]; then
            echo -e "$filename\0icon\x1f$file\0info\x1fcurrent"
        else
            echo -e "$filename\0icon\x1f$file"
        fi
    done
else
    selected_path="$WALL_DIR/$(echo "$@" | awk '{print $1}')"

    if [ -f "$selected_path" ]; then
        # Kill rofi IMMEDIATELY
        killall rofi 2>/dev/null

        # Run everything fully detached in background (no subshell wait)
        nohup bash -c "
            feh --bg-fill '$selected_path'
            wal -i '$selected_path' > /dev/null 2>&1
            ln -sf '$selected_path' ~/wallpapers/current.jpg
            convert '$selected_path' -blur 0x8 -fill black -colorize 30% /tmp/lock_screen.png > /dev/null 2>&1
        " > /dev/null 2>&1 &
    fi
fi