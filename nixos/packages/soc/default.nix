{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  (p "011" pkgs.discord)
  (p "011" pkgs.telegram-desktop)
]