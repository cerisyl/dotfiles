# Applications related to work.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0100" true  "boxfs")
  (p "0100" true  "onedrive")
  (p "0100" true  "openconnect")
  (p "0100" true  "powershell")
  (p "0100" true  "remmina")
  (p "0100" true  "slack")
  (p "0100" true  "teams-for-linux")
  (p "0100" true  "zoom-us")
]
