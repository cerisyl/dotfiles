# Entertainment / gaming programs.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "001" false  "arduino-ide")
  (p "111" false  "deluge-gtk")
  (p "011" false  "dolphin-emu")
  #(p "011" true   "itgmania-bin") manual install
  (p "011" false  "melonDS")
  (p "011" false  "prismlauncher")
  (p "011" false  "soulseekqt")
  (p "011" true   "steam")
  (p "011" true   "steam-original")
  (p "011" true   "steam-unwrapped")
  (p "011" true   "steam-run")
  (p "011" false  "tauon")
  (p "111" false  "vlc")
]