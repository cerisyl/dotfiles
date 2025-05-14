# Capture a full-size screenshot of all screens.

# Check if the target directory exists
mkdir -p "$XDG_SCREENSHOTS_DIR/$(date +%Y-%m)"

# Take the screeshot and save it to the directory
fname="$XDG_SCREENSHOTS_DIR/$(date +%Y-%m)/$(date +%Y-%m-%d_%H-%M-%S).png"
xfce4-screenshooter -f -c -s "$fname"

# Copy to clipboard
# Display a notification that the image was copied
if [ -f $fname ]; then
  xclip -selection clipboard -t image/png -i "$fname"
  notify-send -i "$fname" -t 5000 "Capture" "Saved and copied to clipboard"
fi