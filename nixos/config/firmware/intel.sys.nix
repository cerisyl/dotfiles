{ config, lib, pkgs, myHostname, ... }:
if myHostname == "engrit" then {
  hardware.graphics.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
    intel-media-driver
  ];
} else {}