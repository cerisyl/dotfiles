{ config, pkgMap, theme, getThemeFile, lib, ... }:
if pkgMap ? "looking-glass-client" then {
  programs.looking-glass-client = {
    enable  = true;
    package = pkgMap.looking-glass-client;
    settings.app.shmFile = "/dev/kvmfr0";
  };
} else {}