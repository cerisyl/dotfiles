{ config, pkgMap, theme, getThemeFile, lib, ... }:
if pkgMap ? "thunderbird" then {
  programs.thunderbird = {
    enable      = true;
    package     = pkgMap.thunderbird;
    profiles.main = {
      isDefault = true;
    };
  };
} else {}