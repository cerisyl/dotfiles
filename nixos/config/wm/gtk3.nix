{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  gtk = {
    enable = true;
    gtk3.extraCss = builtins.readFile (getThemeFile "gtk.css");
  };
}