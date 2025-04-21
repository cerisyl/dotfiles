# Cloud file storage services.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  (p "001" "grive2")
  (p "001" "dropbox")
  (p "001" "xfce.thunar-dropbox-plugin")
]