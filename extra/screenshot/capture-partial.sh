#!/bin/bash
# Capture a partial-area screenshot.

# Check if the target directory exists
mkdir -p "/home/ceri/captures/$(date +%Y-%m)"

# Take the screeshot and save it to the directory
fname="/home/ceri/captures/$(date +%Y-%m)/$(date +%Y-%m-%d_%H-%M-%S).png"
xfce4-screenshooter -r -c -s "$fname"

# Copy to clipboard
xclip -selection clipboard -t image/png -i "$fname"

# Display a notification that the image was copied
notify-send -i "$fname" -t 4000 "Capture" "Saved and copied to clipboard"