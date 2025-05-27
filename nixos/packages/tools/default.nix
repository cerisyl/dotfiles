# General tools and utilities; typically lesser-used.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0011" true   "discordchatexporter-desktop")
  (p "0111" false  "ffmpeg")
  (p "0011" false  "freac")
  (p "0011" false  "handbrake")
  (p "1111" false  "imagemagick")
  #(p "0001" false  "imgbrd-grabber") TODO: wait until build is fixed...
  #(p "0011" false  "libreoffice-fresh") on windows
  (p "0111" false  "meld")
  #(p "0011" false  "nine-or-null") manual install
  #(p "0001" false  "ntsc-rs") on windows
  (p "0111" true   "obsidian")
  (p "0001" false  "openrgb")
  (p "1111" false  "partclone")
  (p "0001" false  "puddletag")
  (p "1111" false  "qdirstat")
  (p "1111" false  "qdiskinfo")
  (p "1101" false  "rclone")
  (p "0001" false  "rubyripper")
  (p "0111" false  "tesseract")
  #(p "0001" false  "unmined-gui") manual install
  (p "0011" false  "wineWowPackages.stable")
  (p "0011" false  "winetricks")
  (p "0011" false  "xcolor") # color picker
  (p "0011" true   "yt-dlg")
  (p "0011" true   "yt-dlp")
]