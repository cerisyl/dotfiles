{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  (p "111" pkgs.inter)
  (p "111" pkgs.noto-fonts-cjk-sans)
  (p "111" pkgs.noto-fonts-color-emoji)
  (p "111" pkgs.barlow)
  (p "111" pkgsUnstable.nerd-fonts.jetbrains-mono)
]