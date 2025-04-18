{ config, pkgs, lib, ... }: let
  themeFile = "${config.home.homeDirectory}/extra/theme";
  theme = if builtins.pathExists themeFile
          then builtins.readFile themeFile
          else "ceres";
  themeDir = "${config.home.homeDirectory}/.nix/themes/${theme}";
  extraDir = "${config.home.homeDirectory}/.nix/extra";
in {
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