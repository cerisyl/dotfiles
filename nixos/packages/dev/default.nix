# Development tools.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "1111" true   "bun")
  (p "1011" true   "devenv")
  (p "0001" true   "nodejs_24") # parcel moment
  (p "1111" false  "python313")
  (p "1111" true   "vscode-fhs")
]