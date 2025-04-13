{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  (p "001" pkgs.arduino-ide)
  (p "111" pkgs.deluge-gtk)
  (p "011" pkgs.dolphin-emu)
  #(p "011" pkgs.itgmania-bin) manual install
  (p "011" pkgs.melonDS)
  (p "011" pkgs.prismlauncher)
  (p "011" pkgs.soulseekqt)
  (p "011" pkgs.steam-unwrapped)
  (p "011" pkgs.tauon)
  (p "111" pkgs.vlc)
]