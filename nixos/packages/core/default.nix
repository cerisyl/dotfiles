# Essential programs for everyday use.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0111" false  "birdtray")
  (p "0001" true   "ungoogled-chromium") # Specifically for WebFSR
  (p "1111" true   "mate.engrampa")
  (p "1111" true   "floorp")
  (p "1111" true   "gnome-keyring")
  (p "1111" true   "keepassxc")
  (p "1111" true   "kitty")
  (p "1111" false  "imv")
  (p "1011" false  "rustdesk")
  (p "1111" true   "syncthing")
  (p "1111" true   "syncthingtray")
  (p "0111" true   "thunderbird")
]