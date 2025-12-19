#!/bin/bash

# If lock image doesn't exist, generate it from current wallpaper
if [ ! -f /tmp/lock_screen.png ]; then
    convert $(cat ~/.cache/wal/wal) -blur 0x8 -fill black -colorize 30% /tmp/lock_screen.png
fi

i3lock -i /tmp/lock_screen.png \
  --nofork \
  --ignore-empty-password \
  --radius=80 \
  --ring-width=4 \
  --inside-color=00000000 \
  --ring-color=ffffff33 \
  --line-color=00000000 \
  --keyhl-color=89b4faff \
  --bshl-color=f38ba8ff \
  --insidever-color=00000000 \
  --ringver-color=89b4faff \
  --insidewrong-color=00000000 \
  --ringwrong-color=f38ba8ff \
  --separator-color=00000000 \
  --time-str="%I:%M %p" \
  --time-size=108 \
  --time-color=ffffffff \
  --date-str="%A, %B %d" \
  --date-size=32 \
  --date-color=ffffffaa \
  --verif-text="verifying..." \
  --verif-size=20 \
  --verif-color=89b4faff \
  --wrong-text="incorrect" \
  --wrong-size=20 \
  --wrong-color=f38ba8ff \
  --noinput-text="" \
  --ind-pos="x+w/2:y+h/2+180" \
  --time-pos="x+w/2:y+h/2-120" \
  --date-pos="x+w/2:y+h/2-60" \
  --clock \
  --indicator