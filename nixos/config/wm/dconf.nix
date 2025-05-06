{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme                 = "${theme}-main";
        icon-theme                = "${theme}-icons";
        gtk-enable-primary-paste  = false;
      };
    };
  };
}
