{ config, lib, pkgsUnstable, myHostname, ... }:
if myHostname == "engrit" then {
  services.remmina = {
    enable  = true;
    package = pkgsUnstable.remmina;
  };
} else {}