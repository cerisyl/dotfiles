{ config, lib, pkgs, myHostname, ... }:
if myHostname == "engrit" then {
  services.xserver.videoDrivers = [ "i915" "displaylink" "modesetting" ];
  hardware = {
    graphics.enable = true;
    enableAllFirmware = true;
    opengl.extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
      intel-ocl
      intel-media-driver
    ];
  };
} else {}