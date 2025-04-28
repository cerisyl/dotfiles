#!/bin/bash
# Extract text from a partial-area screenshot using OCR

$fname="/tmp/ocr.png"

xfce4-screenshooter -r -s $fname
$output = $(tesseract $fname -)
echo $output | xclip -sel clip

# Display a notification that the text was copied

# Copy to clipboard
# Display a notification that the image was copied
if [ -f $fname ]; then
  xclip -selection clipboard -t image/png -i $fname
  notify-send -i clipit-trayicon -t 5000 "Copied text" "$output"
fi

# Remove the 
rm $fname