{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  dconf.settings = {
    "/org/gnome/desktop/interface/gtk-theme"                = "${theme}-main";
    "/org/gnome/desktop/interface/icon-theme"               = "${theme}-icons";
    "/org/gnome/desktop/interface/gtk-enable-primary-paste" = false;
  };
}
