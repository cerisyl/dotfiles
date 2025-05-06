{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.rofi = {
    enable    = true;
    package   = pkgMap.rofi;
    terminal  = "kitty";
    # Grid config (used in place as base theme, imports rofi.rasi)
    theme     = (getThemeFile "rofi.rasi");
    extraConfig = {
      modi                = "drun,filebrowser";
      show-icons          = true;
      icon-theme          = "${theme}-icons";
      drun-display-format = "{name}";
      hover-select        = true;
      scrollbar           = true;
      me-select-entry     = "";
      me-accept-entry     = [ "MousePrimary" "MouseSecondary" "MouseDPrimary" ];
      run-shell-command   = "kitty --hold {cmd}";
      kb-cancel           = "Escape,Super_L";
    };
  };
  xdg.configFile = {
    # Grid config for rofimoji
    "rofi/grid.rasi".source = ../../../extra/grid.rasi;
    # Rofimoji config
    "rofimoji.rc".text = ''
      action = copy
      max-recent = 0
      skin-tone = neutral
      hidden-descriptions = true
      selector-args = "-theme ~/.config/rofi/grid.rasi"
      files = [emojis, math, miscellaneous, supplemental, alchemical_symbols, dingbats]
    '';
    # Greenclip config
    "greenclip.toml".text = ''
      [greenclip]
        blacklisted_applications = []
        enable_image_support = true
        history_file = "~/.cache/greenclip.history"
        image_cache_directory = "/tmp/greenclip"
        max_history_length = 10000
        max_selection_size_bytes = 0
        static_history = []
        trim_space_from_selection = false
        use_primary_selection_as_input = false
    '';
  };
}