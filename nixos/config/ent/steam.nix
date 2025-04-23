{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall       = true;
    dedicatedServer.openFirewall  = true;
  };
}
