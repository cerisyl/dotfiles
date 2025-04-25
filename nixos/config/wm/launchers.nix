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
    ## TODO: Figure out how to actually remove these
    "rofi"
    "rofi-theme-selector"
    "xfce4-accessibility-settings"
    "xfce-ui-settings"
    "xfce4-color-settings"
    "xfce4-mime-settings"
    "xfce-keyboard-settings"
    "xfce4-session-logout"
    "xfce4-mail-reader"
    "xfce-mouse-settings"
    "xfce-session-settings"
    "xfce4-settings-editor"
    "xfce4-web-browser"
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
}

