# Social media and other messaging programs.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  (p "011" "discord" true)
  (p "011" "telegram-desktop" true)
]