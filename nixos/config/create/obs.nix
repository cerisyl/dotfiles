{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.obs-studio = {
    enable      = true;
    package     = pkgMap.obs-studio;
  };
}