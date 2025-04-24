{ config, pkgs, pkgMap, theme, getThemeFile, lib, ... }: {
  # XFCE launcher overrides (for things that aren't working in launchers.nix)
  environment.etc = {
    "xdg/applications/xfce4-color-settings".text  = "";
    "xdg/applications/xfce-keyboard-settings".text  = "";
    "xdg/applications/xfce4-mail-reader".text = "";
    "xdg/applications/xfce4-accessibility-settings".text  = "";
    "xdg/applications/xfce4-appearance-settings".text = "";
    "xdg/applications/xfce4-mime-settings".text = "";
    "xdg/applications/xfce-mouse-settings".text = "";
    "xdg/applications/xfce4-notifyd-config".text  = "";
    "xdg/applications/xfce4-session-logout".text  = "";
    "xdg/applications/xfce-session-settings".text = "";
    "xdg/applications/xfce4-settings-editor".text = "";
  };

}