{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.tealdear = {
    enable = true;
    settings.updates.auto_update = true;
  };
}
