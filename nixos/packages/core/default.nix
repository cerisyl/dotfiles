{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in
[
  #(p "011" pkgs.betterbird-bin) #thunderbird
  (p "111" pkgs.btop)
  ##(p "111" pkgs.efibootmgr)
  (p "111" pkgs.floorp)
  (p "111" pkgs.fzf)
  (p "111" pkgs.git)
  (p "111" pkgs.home-manager)
  (p "111" pkgs.keepassxc)
  (p "111" pkgs.kitty)
  ##(p "111" pkgs.linux)
  ##(p "111" pkgs.linux-firmware)
  (p "111" pkgs.micro)
  (p "111" pkgs.neofetch)
  (p "111" pkgs.oh-my-posh)
  (p "100" pkgs.openssh)
  (p "111" pkgs.p7zip)
  (p "111" pkgsUnstable.peazip) # replaced engrampa
  (p "111" pkgs.rustdesk)
  (p "010" pkgs.sof-firmware)
  (p "111" pkgs.syncthing)
  (p "111" pkgs.syncthingtray)
  (p "111" pkgs.tealdeer)
  (p "111" pkgs.unzip)
  #(p "111" pkgs.xnviewmp) needs an alternative
  (p "111" pkgs.zip)
  (p "111" pkgs.zsh)
]