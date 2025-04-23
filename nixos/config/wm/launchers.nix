{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  xdg.desktopEntries = {
    "btop".noDisplay                            = true;
    "kitty".noDisplay                           = true;
    "micro".noDisplay                           = true;
    "nixos-help".noDisplay                      = true;
    "pavucontrol".noDisplay                     = true;
    "rofi".noDisplay                            = true;
    "rofi-theme-selector".noDisplay             = true;
    "thunar-bulk-rename".noDisplay              = true;
    "thunar-setting".noDisplay                  = true;
    "thunar-volman-settings".noDisplay          = true;
    "xfce4-about".noDisplay                     = true;
    "xfce4-accessibility-settings".noDisplay    = true;
    "xfce4-appearance-settings".noDisplay       = true;
    "xfce4-color-settings".noDisplay            = true;
    "xfce4-keyboard-settings".noDisplay         = true;
    "xfce4-mime-settings".noDisplay             = true;
    "xfce4-mouse-settings".noDisplay            = true;
    "xfce4-notifyd-settings".noDisplay          = true;
    "xfce4-session-logout".noDisplay            = true;
    "xfce4-session-settings".noDisplay          = true;
    "xfce4-screensaver-preferences".noDisplay   = true;
    "xfdesktop-settings".noDisplay              = true;
    "xfwm4-settings".noDisplay                  = true;
    "xfwm4-tweaks-settings".noDisplay           = true;
    "xfwm4-workspace-settings".noDisplay        = true;
    "xdg-email".noDisplay                       = true;
    "xdg-open".noDisplay                        = true;
  };
}

# Still to find:
  # Manage Printing
  # Panel