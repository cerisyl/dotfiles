{ config, pkgs, lib, ... }: {
  programs.rofi = {
    enable    = true;
    terminal  = "kitty";
    # Grid config
    theme     = ../../../extra/main.rasi;
    # Actual theme
    xdg.configFile."rofi/rofi.theme".source = ../../../themes/ceres/rofi.theme;
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