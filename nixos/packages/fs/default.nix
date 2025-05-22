# Cloud file storage services.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0001" false  "grive2")
  (p "0001" false  "dropbox")
  (p "0001" false  "xfce.thunar-dropbox-plugin")
]