#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "This script requires root privileges. Please run with sudo."
    exit 1
fi

# Prompt user for time in minutes
echo "Enter the time in minutes after which the system should power off:"
read minutes

# Validate input: check if it's a positive integer
if ! [[ "$minutes" =~ ^[0-9]+$ ]] || [ "$minutes" -le 0 ]; then
    echo "Error: Please enter a positive integer for minutes."
    exit 1
fi

# Convert minutes to seconds for sleep
seconds=$((minutes * 60))

# Inform user of the shutdown schedule
echo "System will power off in $minutes minute(s) ($seconds seconds)."

# Sleep for the specified duration and then power off
sleep "$seconds" && poweroff
