# General tools and utilities; typically lesser-used.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  (p "011" "bcompare")
  #(p "011" "discordchatexporter") needs manual install
  (p "011" "ffmpeg")
  (p "011" "flameshot")
  (p "011" "freac")
  (p "011" "gftp")
  (p "011" "handbrake")
  (p "001" "imgbrd-grabber")
  #(p "011" "libreoffice-fresh") rethink this one?
  #(p "011" "nine-or-null") manual install
  #(p "001" "ntsc-rs") manual install
  (p "011" "obsidian" true)
  (p "011" "obs-studio")
  (p "001" "openrgb")
  (p "001" "puddletag")
  (p "111" "qdirstat")
  (p "111" "qdiskinfo")
  (p "001" "rubyripper")
  #(p "001" "unmined-gui") manual install
  (p "011" "wineWowPackages.stable")
  (p "011" "winetricks")
  (p "011" "yt-dlg" true)
  (p "011" "yt-dlp" true)
]