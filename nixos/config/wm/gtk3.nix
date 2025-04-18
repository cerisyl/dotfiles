{ config, pkgs, lib, ... }: {
  themeFile = "${config.home.homeDirectory}/extra/theme";
  theme = if builtins.pathExists themeFile
          then builtins.readFile themeFile
          else "ceres";
  themeDir = "${config.home.homeDirectory}/.nix/themes/${theme}";
  extraDir = "${config.home.homeDirectory}/.nix/extra";
  gtk.gtk3.extraCss = builtins.readFile "${themeDir}/gtk.theme";
}