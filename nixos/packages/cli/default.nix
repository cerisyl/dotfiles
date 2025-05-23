# Essential/system commands and CLI tools.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "1111" false  "btop")
  (p "1111" false  "fastfetch")
  (p "1111" true   "fd")
  (p "1111" true   "fzf")
  (p "1111" true   "git")
  (p "1111" false  "home-manager")
  (p "1111" false  "killall")
  (p "1111" false  "libnotify")
  (p "1111" false  "micro")
  (p "1111" true   "oh-my-posh")
  (p "1000" false  "openssh")
  (p "1111" false  "pciutils") # mainly for lspci
  (p "1111" false  "p7zip")
  (p "1111" false  "tealdeer")
  (p "1111" false  "unzip")
  (p "1111" true   "zinit" )
  (p "1111" false  "zip")
  (p "1111" true   "zsh")
  (p "1111" true   "zsh-autosuggestions")
  (p "1111" true   "zsh-completions")
  (p "1111" true   "zsh-fzf-tab")
  (p "1111" true   "zsh-syntax-highlighting")
]
