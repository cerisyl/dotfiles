{ config, pkgs, lib, extraDir, themeDir, ... }: {
  gtk.gtk3.extraCss = builtins.readFile "${themeDir}/gtk.theme";
}