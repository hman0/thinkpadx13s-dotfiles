#!/bin/bash

options="Logout\nShutdown\nReboot\nSuspend"
selected=$(echo -e "$options" | tofi --prompt-text="Power Menu: ")

case $selected in
    Logout)
        # Logout
        hyprctl dispatch exit ;;
    Shutdown)
        # Shutdown the system
        loginctl poweroff ;;
    Reboot)
        # Reboot the system
        loginctl reboot ;;
    Suspend)
        # Suspend the system
        loginctl suspend ;;
    *)
        # Exit in case of invalid input or selection
        exit 1 ;;
esac
