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
  home.activation.removeMoreLaunchers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "" > ${pkgMap."rofi"}/share/applications/rofi.desktop
    echo "" > ${pkgMap."rofi"}/share/applications/rofi-theme-selector.desktop
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-accessibility-settings.desktop # Accessibility
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce-ui-settings.desktop             # Appearance
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-color-settings.desktop         # Color Profiles
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-mime-settings.desktop          # Default Applications
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce-keyboard-settings.desktop       # Keyboard
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-session-logout.desktop         # Log Out
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-mail-reader.desktop            # Mail Reader
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce-mouse-settings.desktop          # Mouse & Trackpad
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce-session-settings.desktop        # Session & Startup
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-settings-editor.desktop        # Settings Editor
    echo "" > ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-web-browser.desktop            # Web Browser
  '';
}

