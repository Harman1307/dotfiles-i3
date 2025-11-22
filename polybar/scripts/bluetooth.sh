#!/bin/bash

# Check if bluetooth is on
if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    # Check if device connected
    if bluetoothctl devices Connected 2>/dev/null | grep -q "Device"; then
        echo "󰂯"  # Connected
    else
        echo "󰂲"  # Powered but not connected
    fi
else
    echo "󰂲"  # Powered off
fi
