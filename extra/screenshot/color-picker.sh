#!/bin/bash
# https://askubuntu.com/questions/1183617/color-picker-for-ubuntu-19-10-and-later-releases-as-well
# Pick a color and return it into the clipboard as HEX

# Use Zenity to select an RGB color
color=$(zenity --color-selection)

# Remove the "rgb(" prefix and ")" suffix
color=${color#rgb(}
color=${color%)}

# Split the color into individual RGB values
IFS=',' read -r red green blue <<< "$color"

# Trim leading spaces
red=$(echo "$red" | xargs)
green=$(echo "$green" | xargs)
blue=$(echo "$blue" | xargs)

# Convert RGB to hexadecimal
red_hex=$(printf "%02X" "$red")
green_hex=$(printf "%02X" "$green")
blue_hex=$(printf "%02X" "$blue")

# Combine the RGB values to form the hexadecimal color
hex_color="#$red_hex$green_hex$blue_hex"

# Copy the color to the clipboard for use in other applications
echo -n "$hex_color" | xclip -sel clip

# Display a notification that the hex was copied
notify-send -i xfce4-color-settings -t 5000 "Copied text" "$hex_color"