{ config, pkgMap, theme, getThemeFile, lib, ... }: let
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
    "xfce4-accessibility-settings"
    "xfce4-appearance-settings"
    "xfce-backdrop-settings"
    "xfce4-color-settings"
    "xfce-keyboard-settings"
    "xfce4-mail-reader"
    "xfce4-mime-settings"
    "xfce-mouse-settings"
    "xfce4-notifyd-config"
    "xfce4-session-logout"
    "xfce-session-settings"
    "xfce4-settings-editor"
    "xfce4-screensaver-preferences"
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
  xdg.desktopEntries = {
  } // mappedLaunchers;
}