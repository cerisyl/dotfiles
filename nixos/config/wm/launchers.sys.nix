{ config, pkgs, pkgMap, theme, getThemeFile, lib, ... }: {
  # XFCE launcher overrides (for things that aren't working in launchers.nix)
  environment.etc = {
    "xdg/applications/xfce4-color-settings.desktop".text  = "";
    "xdg/applications/xfce-keyboard-settings.desktop".text  = "";
    "xdg/applications/xfce4-mail-reader.desktop".text = "";
    "xdg/applications/xfce4-accessibility-settings.desktop".text  = "";
    "xdg/applications/xfce4-appearance-settings.desktop".text = "";
    "xdg/applications/xfce4-mime-settings.desktop".text = "";
    "xdg/applications/xfce-mouse-settings.desktop".text = "";
    "xdg/applications/xfce4-notifyd-config.desktop".text  = "";
    "xdg/applications/xfce4-session-logout.desktop".text  = "";
    "xdg/applications/xfce-session-settings.desktop".text = "";
    "xdg/applications/xfce4-settings-editor.desktop".text = "";
  };
}