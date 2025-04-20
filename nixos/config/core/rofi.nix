{ config, pkgs, lib, ... }: {
  programs.rofi = {
    enable    = true;
    terminal  = "kitty";
    # Grid config (used in place as base theme, imports rofi.rasi)
    theme     = ../../../themes/ceres/rofi.rasi;
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
  # Rofimoji config
  xdg.configFile."rofimoji.rc".text = ''
    action = copy
    max-recent = 0
    skin-tone = neutral
    hidden-descriptions = true
    selector-args = "-theme ~/.config/rofi/grid.rasi"
    files = [emojis, math, miscellaneous, supplemental, alchemical_symbols, dingbats]
  ''
  # Grid config for rofimoji
  xdg.configFile."rofi/grid.rasi".source = ../../../extra/grid.rasi;
}