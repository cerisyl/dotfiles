# Firmware/driver packages and applications to interact with drivers
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0110" false  "blueman")
  (p "0100" false  "bolt")
  (p "0100" false  "dbus")
  (p "0100" false  "displaylink")
  (p "0100" false  "linux-firmware")
  (p "0110" false  "sof-firmware")
]