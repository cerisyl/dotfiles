{ config, pkgs, lib, ... }: {
  # Actual theme file
  xdg.configFile."rofi/rofi.rasi".source = ../../../themes/ceres/rofi.rasi;
  programs.rofi = {
    enable    = true;
    terminal  = "kitty";
    # Grid config (used in place as base theme, imports rofi.rasi)
    theme     = ../../../extra/main.rasi;
    extraConfig = {
      modi                = "drun,filebrowser";
      show-icons          = true;
      icon-theme          = "ceres-icons";
      drun-display-format = "{name}";
      hover-select        = true;
      scrollbar           = true;
      me-select-entry     = "";
      me-accept-entry     = [ "MousePrimary" "MouseSecondary" "MouseDPrimary" ];
      run-shell-command   = "kitty --hold {cmd}";
    };
  };
}