{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.thunderbird = {
    enable      = true;
    package     = pkgMap.thunderbird;
    profiles.main = {
      isDefault = true;
    };
  };
}