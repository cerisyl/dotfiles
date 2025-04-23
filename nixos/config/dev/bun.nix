{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.bun = {
    enable      = true;
    package     = pkgMap.bun;
  };
}
