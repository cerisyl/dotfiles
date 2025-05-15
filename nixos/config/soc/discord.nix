{ config, pkgMap, theme, getThemeFile, lib, ... }:
if pkgMap ? "discord" then {
  programs.nixcord = {
    enable = true;

    discord = {
      enable  = true;
      package = pkgMap.discord;
    };
  };
} else {}