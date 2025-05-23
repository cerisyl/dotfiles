# Firmware and driver packages
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0100" false  "bolt")
  (p "0110" false  "brightnessctl")
  (p "0100" false  "linux-firmware")
  (p "0100" false  "mesa")
  (p "0110" false  "sof-firmware")
]