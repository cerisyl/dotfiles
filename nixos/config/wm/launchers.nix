{ config, pkgs, pkgMap, theme, getThemeFile, lib, ... }: let
  removeLaunchers = [
    "btop"
    "cups"
    "kitty"
    "micro"
    "nixos-manual"
    "org.pulseaudio.pavucontrol"
    "panel-preferences"
    "peazip"
    "thunar"
    "thunar-bulk-rename"
    "thunar-settings"
    "syncthing-ui"
    "winetricks"
    "xfce4-about"
    "xfce-backdrop-settings"
    "xfce4-notifyd-config"
    "xfce4-screensaver-preferences"
    "xfce-wm-settings"
    "xfce-wmtweaks-settings"
    "xfce-workspaces-settings"
    "xfce4-screenshooter"
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
  # Create custom launchers here
  xdg.desktopEntries = {
    "lock" = {
      name = "Lock";
      exec = "xflock4";
      icon = "xfsm-lock";
    };
    "restart" = {
      name = "Restart";
      exec = "reboot";
      icon = "xfsm-reboot";
    };
    "shutdown" = {
      name = "Shutdown";
      exec = "shutdown now";
      icon = "xfsm-shutdown";
    };
    "discordchatexporter" = {
      name = "Discord Chat Exporter";
      exec = "discordchatexporter";
      icon = "discord";
    };
  } // mappedLaunchers;
  # Remove hard-to-delete launchers
  config.services.xdg.menu = [
    { source = "${pkgMap.rofi}/share/applications/rofi.desktop"; noDisplay = true; }
    { source = "${pkgMap.rofi}/share/applications/rofi-theme-selector.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-accessibility-settings.desktop"; noDisplay = true; } # Accessibility
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce-ui-settings.desktop" noDisplay = true; }              # Appearance
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-color-settings.desktop" noDisplay = true; }          # Color Profiles
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-mime-settings.desktop" noDisplay = true; }           # Default Applications
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce-keyboard-settings.desktop" noDisplay = true; }        # Keyboard
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-session-logout.desktop" noDisplay = true; }          # Log Out
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-mail-reader.desktop" noDisplay = true; }             # Mail Reader
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce-mouse-settings.desktop" noDisplay = true; }           # Mouse & Trackpad
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce-session-settings.desktop" noDisplay = true; }         # Session & Startup
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-settings-editor.desktop" noDisplay = true; }         # Settings Editor
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-web-browser.desktop" noDisplay = true; }             # Web Browser
  ];
}

