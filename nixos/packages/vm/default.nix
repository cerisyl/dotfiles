# Virtual machine libraries.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0001" false  "looking-glass-client")
  (p "1111" false  "spice")
  (p "1111" false  "spice-protocol")
  (p "1111" false  "qemu_full")
  (p "1111" false  "virt-manager")
  (p "1111" false  "win-virtio")
  (p "1111" false  "win-spice")
  # Share methods
  (p "0001" false  "samba") # for gpu passthrough
  (p "0110" false  "virtiofsd") # default
]