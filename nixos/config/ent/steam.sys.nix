{ config, lib, ... }:
# Stupid, but should work
if config.networking.hostName != "astore" then {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall       = true;
    dedicatedServer.openFirewall  = true;
  };
} else {}