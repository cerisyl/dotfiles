{ config, lib, myHostname, ... }:
# Stupid, but should work
if (myHostname != "engrit" && myHostname != "astore") then {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall       = true;
    dedicatedServer.openFirewall  = true;
  };
} else {}