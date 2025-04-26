#!/bin/bash
# Capture a partial-area screenshot.

# Check if the target directory exists
mkdir -p "~/captures/$(date +%Y-%m)"

# Take the screeshot and save it to the directory
fname="~/captures/$(date +%Y-%m)/$(date +%Y-%m-%d_%H-%M-%S).png"
xfce4-screenshooter -r -c -s "$fname"

# Copy to clipboard
xclip -selection clipboard -t image/png -i "$fname"

# TODO: Display a notification that the image was copied
