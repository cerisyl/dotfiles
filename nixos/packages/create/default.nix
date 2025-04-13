{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  (p "001" pkgs.blender)
  #(p "011" pkgs.fadein) manual install
  (p "011" pkgs.kdePackages.kdenlive)
]