# Window manager tools and add-ins.
let p = init: isUnstable: pkg: { inherit init isUnstable pkg; };
in [
  (p "0110" false  "cbatticon")
  (p "1111" false  "gvfs")
  (p "1111" false  "haskellPackages.greenclip")
  (p "1111" false  "lightdm")
  (p "1111" false  "networkmanager")
  (p "1111" false  "networkmanagerapplet")
  #(p "1111" false  "nody-greeter") # may have to manual install
  (p "1111" false  "plymouth")
  (p "1111" false  "pulseaudio")
  (p "1111" true   "rofi")
  (p "1111" false  "rofimoji")
  (p "1111" false  "volctl")
  (p "1111" false  "wmctrl")
  (p "1111" false  "xclip")
  (p "1111" false  "xfce.thunar-archive-plugin")
  (p "1111" false  "xfce.thunar-media-tags-plugin")
  (p "0110" false  "xfce.xfce4-battery-plugin")
  (p "1111" false  "xfce.xfce4-docklike-plugin")
  (p "1111" false  "xfce.xfce4-genmon-plugin")
  (p "1111" false  "xfce.xfce4-mailwatch-plugin")
  (p "1111" false  "xfce.xfce4-notifyd")
  (p "1111" false  "xfce.xfce4-pulseaudio-plugin")
  (p "1111" false  "xfce.xfce4-screenshooter")
  (p "1111" false  "xfce.xfwm4")
  (p "1111" false  "xmousepasteblock")
]