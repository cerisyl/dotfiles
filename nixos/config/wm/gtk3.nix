{ config, pkgs, lib, ... }: {
  gtk.gtk3.extraCss = builtins.readFile "${config.home.homeDirectory}/.nix/themes/ceres/gtk.theme";
}