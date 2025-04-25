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
    ln -s ${pkgMap."rofi"}/share/applications/rofi.desktop /dev/null
    ln -s ${pkgMap."rofi"}/share/applications/rofi-theme-selector.desktop /dev/null
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-accessibility-settings.desktop /dev/null # Accessibility
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce-ui-settings.desktop /dev/null             # Appearance
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-color-settings.desktop /dev/null         # Color Profiles
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-mime-settings.desktop /dev/null          # Default Applications
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce-keyboard-settings.desktop /dev/null       # Keyboard
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-session-logout.desktop /dev/null         # Log Out
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-mail-reader.desktop /dev/null            # Mail Reader
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce-mouse-settings.desktop /dev/null          # Mouse & Trackpad
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce-session-settings.desktop /dev/null        # Session & Startup
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-settings-editor.desktop /dev/null        # Settings Editor
    ln -s ${pkgs.xfce.xfce4-settings}/share/applications/xfce4-web-browser.desktop /dev/null            # Web Browser
  '';
}

