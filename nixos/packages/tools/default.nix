# General tools and utilities; typically lesser-used.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "011" false  "bcompare")
  (p "011" true   "discordchatexporter-desktop")
  (p "011" false  "ffmpeg")
  (p "011" false  "freac")
  (p "011" false  "gftp")
  (p "011" false  "handbrake")
  (p "111" false  "imagemagick")
  (p "001" false  "imgbrd-grabber")
  #(p "011" false  "libreoffice-fresh") rethink this one?
  #(p "011" false  "nine-or-null") manual install
  #(p "001" false  "ntsc-rs") manual install
  (p "011" true   "obsidian")
  (p "011" false  "obs-studio")
  (p "001" false  "openrgb")
  (p "001" false  "puddletag")
  (p "111" false  "qdirstat")
  (p "111" false  "qdiskinfo")
  (p "001" false  "rubyripper")
  (p "011" false  "tesseract")
  #(p "001" false  "unmined-gui") manual install
  (p "011" false  "wineWowPackages.stable")
  (p "011" false  "winetricks")
  (p "011" true   "yt-dlg")
  (p "011" true   "yt-dlp")
  (p "011" false  "zenity") # color picker
]