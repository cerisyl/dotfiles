# Virtual machine libraries.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "001" false  "looking-glass-client")
  (p "111" false  "spice")
  (p "111" false  "spice-protocol")
  (p "111" false  "qemu_full")
  (p "111" false  "virt-manager")
  (p "111" false  "virtiofsd")
  (p "111" false  "win-virtio")
  (p "111" false  "win-spice")
]