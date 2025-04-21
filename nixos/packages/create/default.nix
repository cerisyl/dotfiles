# Programs for creative output.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  (p "001" "blender")
  #(p "011" "fadein") manual install
  (p "011" "kdePackages.kdenlive")
]