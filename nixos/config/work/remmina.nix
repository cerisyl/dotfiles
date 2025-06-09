{ config, lib, pkgMap, myHostname, ... }:
if myHostname == "engrit" then {
  programs.remmina = {
    enable  = true;
    package = pkgMap.remmina;
  };
} else {}