{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  (p "001" pkgs.grive2)
  (p "001" pkgs.dropbox)
  (p "001" pkgs.xfce.thunar-dropbox-plugin)
]