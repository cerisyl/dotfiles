{ config, lib, pkgs, myHostname, ... }:
if myHostname == "engrit" then {
  services.dbus = {
    enable = true;
    packages = [ pkgs.bolt ];
  };
  services.hardware.bolt = {
    enable  = true;
    package = pkgs.bolt;
  };
} else {}