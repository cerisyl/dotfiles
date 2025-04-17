{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  (p "111" pkgsUnstable.bun)
  (p "111" pkgs.python313)
  (p "111" pkgs.qemu_full)
  (p "111" pkgs.virt-manager)
  (p "111" pkgsUnstable.vscode-with-extensions)
]