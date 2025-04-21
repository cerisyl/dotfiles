{ config, pkgMap, lib, ... }: {
  gtk = {
    enable = true;
    gtk3.extraCss = builtins.readFile ../../../themes/ceres/gtk.css;
  };
}