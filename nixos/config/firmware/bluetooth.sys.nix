{ config, lib, pkgs, myHostname, ... }:
if (myHostname == "luxe" || myHostname == "engrit") then {
  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
} else {}