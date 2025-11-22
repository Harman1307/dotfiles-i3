#!/bin/bash
sleep 3
while true; do
    for win in $(xdotool search --class firefox); do
        compton-trans -w $win 80 2>/dev/null
    done
    sleep 5
done
