# Essential programs for everyday use.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  #(p "011" "betterbird-bin") #thunderbird
  (p "111" "floorp" true)
  (p "111" "keepassxc" true)
  (p "111" "kitty" true)
  (p "111" "peazip" true) # replaced engrampa
  (p "111" "rustdesk")
  (p "111" "syncthing" true)
  (p "111" "syncthingtray" true)
  #(p "111" "xnviewmp") needs an alternative
]