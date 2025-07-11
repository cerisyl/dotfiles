{ config, pkgMap, theme, getThemeFile, homedir, myHostname, lib, ... }: let
  displays = {
    lux = {
      "Default/DP-1/RefreshRate" = 143.972318;
    };
    nova = {
      # "Default/DP-1/RefreshRate" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
    engrit = {
      # Left DP monitor
      "Default/DP-1-1/Primary"      = true;
      "Default/DP-1-1/RefreshRate"  = 120;
      "Default/DP-2-1/Primary"      = true;
      "Default/DP-2-1/RefreshRate"  = 120;
      # Right DP monitor
      "Default/DP-1-2/Primary"      = false;
      "Default/DP-1-2/RefreshRate"  = 120;
      "Default/DP-2-2/Primary"      = false;
      "Default/DP-2-2/RefreshRate"  = 120;
    };
    medea = {
      # ...
    };
    astore = {
      # "Default/HDMI-0/RefreshRate" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
    vm = {
      # "Default/Virtual-1/RefreshRate" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
  };
in {
  xfconf.settings.displays = displays."${myHostname}";
}
