{ config, pkgs, pkgMap, theme, getThemeFile, lib, ... }: let
  # List of launchers to remove
  removeLaunchers = [
    "btop"
    "cups"
    "kitty"
    "micro"
    "nixos-manual"
    "org.pulseaudio.pavucontrol"
    "panel-preferences"
    "peazip"
    "rofi"
    "rofi-theme-selector"
    "thunar"
    "thunar-bulk-rename"
    "thunar-settings"
    "syncthing-ui"
    "winetricks"
    "xfce4-about"
    "xfce-backdrop-settings"
    "xfce4-screensaver-preferences"
    "xfce-ui-settings"
    "xfce4-web-browser"
    "xfce-wm-settings"
    "xfce-wmtweaks-settings"
    "xfce-workspaces-settings"
  ];
  mappedLaunchers = builtins.listToAttrs (map (name: {
    inherit name;
    exec = name;
    value = {
      inherit name;
      noDisplay = true;
    };
  }) removeLaunchers);
in {
  # List of new launchers to create
  xdg.desktopEntries = {
  } // mappedLaunchers;
}