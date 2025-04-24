{ config, pkgMap, theme, getThemeFile, lib, ... }: let
  removeLaunchers = [
    "btop"
    "cups"
    "kitty"
    "micro"
    "nixos-manual"
    "org.pulseaudio.pavucontrol"
    "rofi"
    "rofi-theme-selector"
    "thunar-bulk-rename"
    "thunar-settings"
    "xfce4-about"
    "xfce4-accessibility-settings"
    "xfce4-appearance-settings"
    "xfce4-color-settings"
    "xfce-keyboard-settings"
    "xfce-mail-reader"
    "xfce4-mime-settings"
    "xfce4-mouse-settings"
    "xfce4-notifyd-settings"
    "xfce4-panel"
    "xfce4-session-logout"
    "xfce4-session-settings"
    "xfce4-screensaver-preferences"
    "xfce-web-browser"
    "xfce-wm-settings"
    "xfce-wmtweaks-settings"
    "xfce-workspace-settings"
    "xfdesktop-settings"
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