{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  dconf.settings = {
    "/org/gnome/desktop/interface/gtk-enable-primary-paste" = "false";
  };
}
