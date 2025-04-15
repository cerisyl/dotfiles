{ config, pkgs, lib, ... }: {
  boot = {
    consoleLogLevel = 0;
    kernelParams = [ "quiet" "udev.log_level=0" "splash" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable          = true;
        devices         = [ "nodev" ];
        efiSupport      = true;
        useOSProber     = true;
        #timeoutStyle    = "hidden";
        backgroundColor = "#1a1a1f";
        splashImage     = null;
      };
    };
  };
}