# Essential/system command line tools.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  (p "111" "btop")
  (p "111" "fastfetch")
  (p "111" "fzf" true)
  (p "111" "git" true)
  (p "111" "home-manager")
  (p "111" "killall")
  (p "111" "micro")
  (p "111" "oh-my-posh" true)
  (p "100" "openssh")
  (p "111" "p7zip")
  (p "010" "sof-firmware")
  (p "111" "tealdeer")
  (p "111" "unzip")
  (p "111" "zinit" true)
  (p "111" "zip")
  (p "111" "zsh" true)
  (p "111" "zsh-fzf-tab" true)
]