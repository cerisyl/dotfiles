{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  (p "011" pkgs.bcompare)
  #(p "011" pkgs.discordchatexporter) needs manual install
  (p "011" pkgs.ffmpeg)
  (p "011" pkgs.flameshot)
  (p "011" pkgs.freac)
  (p "011" pkgs.gftp)
  (p "011" pkgs.handbrake)
  (p "001" pkgs.imgbrd-grabber)
  #(p "011" pkgs.libreoffice-fresh) rethink this one?
  #(p "011" pkgs.nine-or-null) manual install
  #(p "001" pkgs.ntsc-rs) manual install
  (p "011" pkgs.obsidian)
  (p "011" pkgs.obs-studio)
  (p "001" pkgs.openrgb)
  (p "001" pkgs.puddletag)
  (p "111" pkgs.qdirstat)
  (p "111" pkgs.qdiskinfo)
  (p "001" pkgs.rubyripper)
  #(p "001" pkgs.unmined-gui) manual install
  (p "011" pkgs.wineWowPackages.stable)
  (p "011" pkgs.winetricks)
  (p "011" pkgs.yt-dlg)
  (p "011" pkgs.yt-dlp)
]