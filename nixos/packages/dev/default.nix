# Development tools.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "111" true   "bun")
  (p "111" false  "python313")
  (p "111" false  "qemu_full")
  (p "111" false  "virt-manager")
  (p "111" true   "vscode-fhs")
]