#!/bin/bash

# Prevent multiple instances
if pgrep -f "lock-prep.sh" | grep -v $$ > /dev/null; then
    exit 0
fi

while true; do
  RESOLUTION=$(xdpyinfo | grep dimensions | awk '{print $2}')
  
  # Use current wallpaper from pywal instead of random
  WALLPAPER=$(cat ~/.cache/wal/wal 2>/dev/null)
  
  # Fallback to random if wal file doesn't exist
  if [ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ]; then
    WALLPAPER=$(find ~/wallpapers -type f 2>/dev/null | shuf -n 1)
  fi
  
  LOCK_IMG=/tmp/lock_screen.png
  
  if [ -n "$WALLPAPER" ]; then
    magick "$WALLPAPER" \
      -resize "${RESOLUTION}^" \
      -gravity center \
      -extent "${RESOLUTION}" \
      -blur 0x25 \
      -fill black -colorize 75% \
      "$LOCK_IMG" 2>/dev/null
  fi
  
  sleep 300
done
