#!/bin/bash
# Prevent multiple instances
if pgrep -f "lock-prep.sh" | grep -v $$ > /dev/null; then
    exit 0
fi

while true; do
  RESOLUTION=$(xdpyinfo | grep dimensions | awk '{print $2}')

  # Only use current pywal wallpaper (no random fallback/repetition)
  WALLPAPER=$(cat ~/.cache/wal/wal 2>/dev/null)

  LOCK_IMG=/tmp/lock_screen.png

  if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
    magick "$WALLPAPER" \
      -resize "${RESOLUTION}>" \   # Fit inside screen (scale down only, keep aspect, no enlarge/crop)
      -background black \          # Black bars for letterbox
      -gravity center \            # Center the image
      -extent "${RESOLUTION}" \    # Pad to exact resolution
      -blur 0x25 \
      -fill black -colorize 75% \
      "$LOCK_IMG" 2>/dev/null
  fi

  sleep 300
done