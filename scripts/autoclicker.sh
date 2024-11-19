#!/bin/bash

# Adjustable speed in milliseconds (default 100 ms)
CLICK_DELAY=100

# File to store the script's PID
PID_FILE="/tmp/autoclicker.pid"

# Function to start the auto-clicker
start_clicker() {
    echo "Auto-clicker enabled. Press the shortcut again to stop."
    while :; do
        xdotool click 1
        sleep $(bc <<< "scale=3; $CLICK_DELAY/1000")
    done
}

# Toggle function
toggle_clicker() {
    if [ -f "$PID_FILE" ]; then
        # Stop the running script
        kill "$(cat "$PID_FILE")"
        rm "$PID_FILE"
        echo "Auto-clicker disabled."
    else
        # Start the auto-clicker
        start_clicker &
        echo $! > "$PID_FILE"
    fi
}

# Toggle the auto-clicker
toggle_clicker
