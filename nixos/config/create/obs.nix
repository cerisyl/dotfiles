{ config, pkgMap, theme, getThemeFile, hostname, lib, ... }:
if pkgMap ? "obs-studio" then {
  programs.obs-studio = {
    enable      = true;
    package     = pkgMap.obs-studio;
  };
} else {}