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
    "rofi"
    "rofi-theme-selector"
    "thunar"
    "thunar-bulk-rename"
    "thunar-settings"
    "syncthing-ui"
    "winetricks"
    "xfce4-about"
    "xfce-backdrop-settings"
    "xfce4-screensaver-preferences"
    "xfce-ui-settings"
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
  # Removal overrides (for things that aren't working)
  services.xdg.menu.itemOverrides = [
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-color-settings.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce-keyboard-settings.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-mail-reader.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-accessibility-settings.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-appearance-settings.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-mime-settings.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce-mouse-settings.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-notifyd-config.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-session-logout.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce-session-settings.desktop"; noDisplay = true; }
    { source = "${pkgs.xfce.xfce4-settings}/share/applications/xfce4-settings-editor.desktop"; noDisplay = true; }
  ];
}

