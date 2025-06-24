{ config, lib, pkgMap, myHostname, ... }:
if myHostname == "engrit" then {
  services.remmina = {
    enable  = true;
    package = pkgMap.remmina;
  };
} else {}