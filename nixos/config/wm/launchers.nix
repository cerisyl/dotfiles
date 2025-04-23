{ config, pkgMap, theme, getThemeFile, lib, ... }: let
  l = name: exec: { inherit name exec; };
  removeLaunchers = [
    (l "btop++"                 "btop")
    (l "Manage Printing"        "cups")
    (l "Kitty"                  "kitty")
    (l "Micro"                  "micro")
    (l "NixOS Manual"           "nixos-help")
    (l "Volume Control"         "pavucontrol")
    (l "Rofi"                   "rofi")
    (l "Rofi Theme Selector"    "rofi-theme-selector")
    (l "Bulk Rename"            "thunar-bulk-rename")
    (l "File Manager Settings"  "thunar-settings")
    (l "About Xfce"             "xfce4-about")
    (l "Accessibility"          "xfce4-accessibility-settings")
    (l "Appearance"             "xfce4-appearance-settings")
    (l "Color Profiles"         "xfce4-color-settings")
    (l "Keyboard"               "xfce4-keyboard-settings")
    (l "Default Applications"   "xfce4-mime-settings")
    (l "Mouse and Touchpad"     "xfce4-mouse-settings")
    (l "Notifications"          "xfce4-notifyd-settings")
    (l "Panel"                  "xfce4-panel")
    (l "Logout"                 "xfce4-session-logout")
    (l "Session and Startup"    "xfce4-session-settings")
    (l "Xfce Screensaver"       "xfce4-screensaver-preferences")
    (l "Desktop"                "xfdesktop-settings")
    (l "Window Manager"         "xfwm4-settings")
    (l "Window Manager Tweaks"  "xfwm4-tweaks-settings")
    (l "Workspaces"             "xfwm4-workspace-settings")
    (l "Mail Reader"            "xdg-email")
    (l "Web Browser"            "xdg-open")
  ];
  mappedLaunchers = builtins.listToAttrs (map (entry: {
    name = entry.name;
    exec = entry.exec;
    value.noDisplay = true;
  }) removeLaunchers);
in {
  xdg.desktopEntries = {
  } // mappedLaunchers;
}