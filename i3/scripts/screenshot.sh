#!/bin/bash

dir=~/screenshots
mkdir -p "$dir"
file="$dir/$(date +%Y%m%d-%H%M%S).png"

if [[ "$1" == "select" ]]; then
    maim -s "$file"
else
    maim "$file"
fi

if [[ -f "$file" ]]; then
    xclip -selection clipboard -t image/png < "$file"
    notify-send "Screenshot saved" "$file" -i "$file"
else
    notify-send "Screenshot cancelled"
fi
