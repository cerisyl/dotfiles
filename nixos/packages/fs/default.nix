# Cloud file storage services.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "001" false  "grive2")
  (p "001" false  "dropbox")
  (p "001" false  "xfce.thunar-dropbox-plugin")
]