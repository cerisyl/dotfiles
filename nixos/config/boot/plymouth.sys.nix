{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  boot.plymouth = {
    enable = true;
    theme  = "spinner";
    logo   = "/home/ceri/.nix/themes/ceres/img/boot.png";
  };
}