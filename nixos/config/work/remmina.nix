{ config, lib, pkgsUnstable, myHostname, ... }:
if myHostname == "engrit" then {
  programs.remmina = {
    enable  = true;
    package = pkgsUnstable.remmina;
  };
} else {}