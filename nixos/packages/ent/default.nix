# Entertainment / gaming programs.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0001" false  "arduino-ide")
  (p "1011" false  "deluge-gtk")
  (p "0011" false  "dolphin-emu")
  (p "0011" true   "itgmania")
  (p "0011" false  "melonDS")
  (p "0011" false  "prismlauncher")
  (p "0011" false  "soulseekqt")
  (p "0011" true   "steam")
  (p "0011" true   "steam-unwrapped")
  (p "0011" true   "steam-run")
  (p "0111" false  "tauon")
  (p "1111" false  "vlc")
]