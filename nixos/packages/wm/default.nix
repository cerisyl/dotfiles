{ pkgs, pkgsUnstable }: let p = init: pkg: { inherit pkg init; };
in [
  (p "111" pkgs.dockbarx)
  (p "111" pkgs.gvfs)
  (p "111" pkgs.haskellPackages.greenclip)
  (p "111" pkgs.lightdm)
  (p "111" pkgs.lightlocker)
  (p "111" pkgs.networkmanager)
  (p "111" pkgs.networkmanagerapplet)
  #(p "111" pkgs.nody-greeter) # may have to manual install
  (p "111" pkgs.pavucontrol)
  (p "111" pkgs.plymouth)
  #(p "111" pkgs.plymouth-theme-arch10) # may have to manual install
  (p "111" pkgs.pulseaudio)
  (p "111" pkgsUnstable.rofi)
  #(p "111" pkgs.rofi-file-browser) #might be fucked, might want to use unstable...idk
  (p "111" pkgs.rofimoji)
  (p "111" pkgs.wmctrl)
  (p "111" pkgs.xclip)
  (p "111" pkgs.xfce.thunar-archive-plugin)
  (p "111" pkgs.xfce.thunar-media-tags-plugin)
  (p "010" pkgs.xfce.xfce4-battery-plugin)
  (p "111" pkgs.xfce.xfce4-dockbarx-plugin)
  (p "111" pkgs.xfce.xfce4-genmon-plugin)
  (p "111" pkgs.xfce.xfce4-mailwatch-plugin)
  (p "111" pkgs.xfce.xfce4-notifyd)
  (p "111" pkgs.xfce.xfce4-pulseaudio-plugin)
  (p "111" pkgs.xfce.xfwm4)
]