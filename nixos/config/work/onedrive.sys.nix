{ config, lib, pkgsUnstable, myHostname, ... }:
if myHostname == "engrit" then {
  services.onedrive = {
    enable  = true;
    package = pkgsUnstable.onedrive;
  };
} else {}