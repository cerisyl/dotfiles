{ config, pkgs, lib, ... }: {
  gtk.gtk3.extraCss = builtins.readFile ../../../themes/ceres/gtk.theme;
}