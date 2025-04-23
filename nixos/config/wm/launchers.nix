{ config, pkgMap, theme, getThemeFile, lib, ... }: let
  removeLaunchers = [
    "btop++"
    "cups"
    "kitty"
    "micro"
    "nixos-help"
    "pavucontrol"
    "rofi"
    "rofi-theme-selector"
    "thunar-bulk-rename"
    "thunar-settings"
    "thunar-volman-settings"
    "xfce4-about"
    "xfce4-accessibility-settings"
    "xfce4-appearance-settings"
    "xfce4-color-settings"
    "xfce4-keyboard-settings"
    "xfce4-mime-settings"
    "xfce4-mouse-settings"
    "xfce4-notifyd-settings"
    "xfce4-panel"
    "xfce4-session-logout"
    "xfce4-session-settings"
    "xfce4-screensaver-preferences"
    "xfdesktop-settings"
    "xfwm4-settings"
    "xfwm4-tweaks-settings"
    "xfwm4-workspace-settings"
    "xdg-email"
    "xdg-open"
  ];
  mappedLaunchers = builtins.listToAttrs (map (name: {
    inherit name;
    value.noDisplay = true;
  }) removeLaunchers);
in {
  xdg.desktopEntries = {
  } // mappedLaunchers;
}