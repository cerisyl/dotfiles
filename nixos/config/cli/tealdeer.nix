{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.teeldeer = {
    enable = true;
    settings.updates.auto_update = true;
  };
}
