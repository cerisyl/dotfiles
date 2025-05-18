{ config, pkgMap, theme, getThemeFile, homedir, myHostname, lib, ... }: let
  displays = {
    lux = {
      "Default/DP-1/RefreshRate" = 143.972318;
    };
    nova = {
      # "Default/DP-1/RefreshRate" = "${homedir}/.nix/themes/${theme}/img/bg.png";
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