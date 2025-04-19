{ config, pkgs, lib, ... }: {
  gtk = {
    enable = true;
    gtk3.extraCss = builtins.readFile ../../../themes/ceres/gtk.theme;
  };
}