# Social media and other messaging programs.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0011" true   "discord")
  (p "0011" true   "telegram-desktop")
]