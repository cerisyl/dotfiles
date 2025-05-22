# Programs for creative output.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0001" false  "blender")
  #(p "0011" false  "fadein") manual install
  (p "0011" false  "kdePackages.kdenlive")
  (p "0011" false  "obs-studio")
  (p "0001" false  "reaper")
]