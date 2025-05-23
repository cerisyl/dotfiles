{ config, lib, pkgs, myHostname, ... }:
if myHostname == "engrit" then {
  services.xserver.videoDrivers = [ "i915" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ vaapiIntel intel-media-driver ];
  };

} else {}