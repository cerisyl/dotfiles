#!/bin/bash
# Extract text from a partial-area screenshot using OCR

xfce4-screenshooter -r -s /tmp/save.png
$output = $(tesseract /tmp/save.png)
echo $output | xclip -sel clip

# Display a notification that the text was copied
notify-send -i clipit-trayicon -t 5000 "Copied text" "$output"