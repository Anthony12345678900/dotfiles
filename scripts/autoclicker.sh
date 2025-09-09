#!/bin/bash

# Adjustable speed in milliseconds (default: 100 ms)
CLICK_DELAY=1

# File to store the script's PID
PID_FILE="/tmp/autoclicker.pid"

# Function to start the auto-clicker
start_clicker() {
    notify-send -a "AutoClicker" "AutoClicker ON" "Click delay: ${CLICK_DELAY}ms"
    while :; do
        xdotool click 1
        sleep "$(awk "BEGIN { printf \"%.3f\", $CLICK_DELAY/1000 }")"
    done
}

# Function to stop the auto-clicker
stop_clicker() {
    if [ -f "$PID_FILE" ]; then
        kill "$(cat "$PID_FILE")" 2>/dev/null
        rm "$PID_FILE"
        notify-send -a "AutoClicker" "AutoClicker OFF" "Stopped clicking"
    fi
}

# Toggle function
toggle_clicker() {
    if [ -f "$PID_FILE" ]; then
        stop_clicker
    else
        start_clicker &
        echo $! > "$PID_FILE"
    fi
}

# Toggle the auto-clicker
toggle_clicker
