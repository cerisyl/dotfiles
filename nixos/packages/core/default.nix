# Essential programs for everyday use.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "011" false  "birdtray")
  (p "001" true   "chromium")
  (p "111" true   "mate.engrampa")
  (p "111" true   "floorp")
  (p "111" true   "gnome-keyring")
  (p "111" true   "keepassxc")
  (p "111" true   "kitty")
  (p "111" false  "imv")
  (p "111" false  "rustdesk")
  (p "111" true   "syncthing")
  (p "111" true   "syncthingtray")
  (p "011" true   "thunderbird")
]