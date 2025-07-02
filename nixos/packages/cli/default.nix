# Essential/system commands and CLI tools.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "lname" false  "btop")
  (p "lname" false  "fastfetch")
  (p "lname" true   "fd")
  (p "lname" true   "fzf")
  (p "lname" true   "git")
  (p "lna e" true   "git-lfs")
  (p "lname" false  "home-manager")
  (p "lname" false  "killall")
  (p "lname" false  "libnotify")
  (p "lname" false  "micro")
  (p "lname" true   "oh-my-posh")
  (p "  a  " false  "openssh")
  (p "lname" false  "pciutils") # lspci
  (p "lname" false  "p7zip")
  (p "lname" false  "tealdeer")
  (p "lname" false  "unzip")
  (p "lname" false  "usbutils") # lsusb
  (p "lname" true   "zinit" )
  (p "lname" false  "zip")
  (p "lname" true   "zsh")
  (p "lname" true   "zsh-autosuggestions")
  (p "lname" true   "zsh-completions")
  (p "lname" true   "zsh-fzf-tab")
  (p "lname" true   "zsh-syntax-highlighting")
]
