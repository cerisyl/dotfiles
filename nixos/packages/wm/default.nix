# Window manager tools and add-ins.
let p = init: pkg: isUnstable ? false: { inherit pkg init isUnstable; };
in [
  (p "111" "dockbarx")
  (p "111" "gvfs")
  (p "111" "haskellPackages.greenclip")
  (p "111" "lightdm")
  (p "111" "lightlocker")
  (p "111" "networkmanager")
  (p "111" "networkmanagerapplet")
  #(p "111" "nody-greeter") # may have to manual install
  (p "111" "pavucontrol")
  (p "111" "plymouth")
  #(p "111" "plymouth-theme-arch10") # may have to manual install
  (p "111" "pulseaudio")
  (p "111" "rofi" true)
  (p "111" "rofimoji")
  (p "111" "wmctrl")
  (p "111" "xclip")
  (p "111" "xfce.thunar-archive-plugin")
  (p "111" "xfce.thunar-media-tags-plugin")
  (p "010" "xfce.xfce4-battery-plugin")
  (p "111" "xfce.xfce4-dockbarx-plugin")
  (p "111" "xfce.xfce4-genmon-plugin")
  (p "111" "xfce.xfce4-mailwatch-plugin")
  (p "111" "xfce.xfce4-notifyd")
  (p "111" "xfce.xfce4-pulseaudio-plugin")
  (p "111" "xfce.xfwm4")
]