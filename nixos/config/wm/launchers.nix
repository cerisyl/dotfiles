{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  xdg.desktopEntries = {
    "btop.desktop".noDisplay                          = true;
    "kitty.desktop".noDisplay                         = true;
    "micro.desktop".noDisplay                         = true;
    "nixos-help.desktop".noDisplay                    = true;
    "pavucontrol.desktop".noDisplay                   = true;
    "rofi.desktop".noDisplay                          = true;
    "rofi-theme-selector.desktop".noDisplay           = true;
    "thunar-bulk-rename.desktop".noDisplay            = true;
    "thunar-setting.desktop".noDisplay                = true;
    "thunar-volman-settings.desktop".noDisplay        = true;
    "xfce4-about.desktop".noDisplay                   = true;
    "xfce4-accessibility-settings.desktop".noDisplay  = true;
    "xfce4-appearance-settings.desktop".noDisplay     = true;
    "xfce4-color-settings.desktop".noDisplay          = true;
    "xfce4-keyboard-settings.desktop".noDisplay       = true;
    "xfce4-mime-settings.desktop".noDisplay           = true;
    "xfce4-mouse-settings.desktop".noDisplay          = true;
    "xfce4-notifyd-settings.desktop".noDisplay        = true;
    "xfce4-session-logout.desktop".noDisplay          = true;
    "xfce4-session-settings.desktop".noDisplay        = true;
    "xfce4-screensaver-preferences.desktop".noDisplay = true;
    "xfdesktop-settings.desktop".noDisplay            = true;
    "xfwm4-settings.desktop".noDisplay                = true;
    "xfwm4-tweaks-settings.desktop".noDisplay         = true;
    "xfwm4-workspace-settings.desktop".noDisplay      = true;
    "xdg-email.desktop".noDisplay                     = true;
    "xdg-open.desktop".noDisplay                      = true;
  };
}

# Still to find:
  # Manage Printing
  # Panel