{ config, pkgMap, lib, ... }:
if pkgMap ? "steam" then {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall       = true;
    dedicatedServer.openFirewall  = true;
  };
} else {}