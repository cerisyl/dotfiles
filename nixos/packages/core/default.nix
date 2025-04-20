{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  #(p "011" pkgs.betterbird-bin) #thunderbird
  (p "111" pkgs.btop)
  (p "111" pkgs.fastfetch)
  (p "111" pkgsUnstable.floorp)
  (p "111" pkgsUnstable.fzf)
  (p "111" pkgsUnstable.git)
  (p "111" pkgs.home-manager)
  (p "111" pkgsUnstable.keepassxc)
  (p "111" pkgs.killall)
  (p "111" pkgsUnstable.kitty)
  (p "111" pkgs.micro)
  (p "111" pkgsUnstable.oh-my-posh)
  (p "100" pkgs.openssh)
  (p "111" pkgs.p7zip)
  (p "111" pkgsUnstable.peazip) # replaced engrampa
  (p "111" pkgs.rustdesk)
  (p "010" pkgs.sof-firmware)
  (p "111" pkgsUnstable.syncthing)
  (p "111" pkgsUnstable.syncthingtray)
  (p "111" pkgs.tealdeer)
  (p "111" pkgs.unzip)
  #(p "111" pkgs.xnviewmp) needs an alternative
  (p "111" pkgsUnstable.zinit)
  (p "111" pkgs.zip)
  (p "111" pkgsUnstable.zsh)
  (p "111" pkgsUnstable.zsh-fzf-tab)
]