#!/bin/bash
# Extract text from a partial-area screenshot using OCR

xfce4-screenshooter -r -s /tmp/save.png
tesseract /tmp/save.png - | xclip

