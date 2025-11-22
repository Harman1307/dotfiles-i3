#!/bin/bash
options="󰌾 Lock\n󰍃 Logout\n󰜉 Reboot\n󰐥 Shutdown"
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme-str 'window {width: 250px;}')

case $chosen in
    *Lock) ~/.config/i3/lock.sh ;;
    *Logout) i3-msg exit ;;
    *Reboot) systemctl reboot ;;
    *Shutdown) systemctl poweroff ;;
esac
