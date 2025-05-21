# Programs for creative output.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "001" false  "blender")
  #(p "011" false  "fadein") manual install
  (p "011" false  "kdePackages.kdenlive")
  (p "011" false  "obs-studio")
  (p "001" false  "reaper")
]