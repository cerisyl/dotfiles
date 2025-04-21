# Entertainment / gaming programs.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  (p "001" "arduino-ide")
  (p "111" "deluge-gtk")
  (p "011" "dolphin-emu")
  #(p "011" "itgmania-bin") manual install
  (p "011" "melonDS")
  (p "011" "prismlauncher")
  (p "011" "soulseekqt")
  (p "011" "steam-unwrapped")
  (p "011" "tauon")
  (p "111" "vlc")
]