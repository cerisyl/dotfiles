{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  boot.plymouth = {
    enable = true;
    theme  = "spinner";
    logo   = ../../../themes/ceres/img/boot.png;
  };
}