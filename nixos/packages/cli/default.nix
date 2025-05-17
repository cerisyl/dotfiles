# Essential/system commands and CLI tools.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "111" false  "btop")
  (p "111" false  "fastfetch")
  (p "111" true   "fd")
  (p "111" true   "fzf")
  (p "111" true   "git")
  (p "111" false  "home-manager")
  (p "111" false  "killall")
  (p "111" false  "libnotify")
  (p "111" false  "micro")
  (p "111" true   "oh-my-posh")
  (p "100" false  "openssh")
  (p "111" false  "pciutils") # mainly for lspci
  (p "111" false  "p7zip")
  (p "010" false  "sof-firmware")
  (p "111" false  "tealdeer")
  (p "111" false  "unzip")
  (p "111" true   "zinit" )
  (p "111" false  "zip")
  (p "111" true   "zsh")
  (p "111" true   "zsh-autosuggestions")
  (p "111" true   "zsh-completions")
  (p "111" true   "zsh-fzf-tab")
  (p "111" true   "zsh-syntax-highlighting")
]