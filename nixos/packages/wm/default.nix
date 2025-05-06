# Window manager tools and add-ins.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "111" false  "gvfs")
  (p "111" false  "haskellPackages.greenclip")
  (p "111" false  "lightdm")
  (p "111" false  "networkmanager")
  (p "111" false  "networkmanagerapplet")
  #(p "111" false  "nody-greeter") # may have to manual install
  (p "111" false  "pasystray") # Replaces pavucontrol
  (p "111" false  "plymouth")
  #(p "111" false  "plymouth-theme-arch10") # may have to manual install
  (p "111" false  "pulseaudio")
  (p "111" true   "rofi")
  (p "111" false  "rofimoji")
  (p "111" false  "wmctrl")
  (p "111" false  "xclip")
  (p "111" false  "xfce.thunar-archive-plugin")
  (p "111" false  "xfce.thunar-media-tags-plugin")
  (p "010" false  "xfce.xfce4-battery-plugin")
  (p "111" false  "xfce.xfce4-docklike-plugin")
  (p "111" false  "xfce.xfce4-genmon-plugin")
  (p "111" false  "xfce.xfce4-mailwatch-plugin")
  (p "111" false  "xfce.xfce4-notifyd")
  (p "111" false  "xfce.xfce4-pulseaudio-plugin")
  (p "111" false  "xfce.xfce4-screenshooter")
  (p "111" false  "xfce.xfwm4")
]