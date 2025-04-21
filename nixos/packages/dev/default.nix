# Development tools.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  (p "111" "bun" true)
  (p "111" "python313")
  (p "111" "qemu_full")
  (p "111" "virt-manager")
  (p "111" "vscode-with-extensions" true)
]