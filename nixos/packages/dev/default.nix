# Development tools.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "1111" true   "bun")
  (p "0001" true   "nodejs_24") # parcel moment
  (p "0011" false  "python311") # 9ornull moment (all my homies hate wxpython)
  (p "1111" false  "python313")
  (p "1111" true   "vscode-fhs")
]