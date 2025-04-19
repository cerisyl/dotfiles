{ config, pkgs, lib, ... }: {
  xfconf.settings = {
    # Session
    xfce-session = {
      "general/LockCommand" = "${pkgs.lightdm}/bin/dm-tool lock";
    };
    # Background + desktop
    xfce4-desktop = {
      # Background
      "backdrop/screen0/monitorVirtual-1/workspace0/last-image" = "${config.home.homeDirectory}/.nix/themes/ceres/img/bg.png;
      # Desktop icons
      "desktop-icons/show-tooltips"               = false;
      "desktop-icons/file-icons/show-removable"   = false;
      "desktop-icons/file-icons/show-filesystem"  = false;
      "desktop-icons/file-icons/show-trash"       = true;
      "desktop-icons/file-icons/show-home"        = true;
      "desktop-icons/show-hidden-files"           = false;
      "desktop-icons/single-click"                = true;
      "desktop-icons/font-size"                   = 9;
      "desktop-icons/icon-size"                   = 48;
    };
    # TODO: Keyboard shortcuts
    xfce4-keyboard-shortcuts = {
    };
    # TODO: Notify daemon
    xfce4-notifyd = {
    };
    # TODO: Taskbar
    xfce4-panel = {
    };
    # TODO: ???
    xfwm4 = {
    };
    # Thunar settings
    thunar = {
      "last-separator-position"           = 160;
      "last-details-view-zoom-level"      = "THUNAR_ZOOM_LEVEL_25_PERCENT";
      "last-sort-column"                  = "THUNAR_COLUMN_NAME";
      "last-sort-order"                   = "GTK_SORT_ASCENDING";
      "misc-single-click"                 = true;
      "misc-thumbnail-draw-frames"        = false;
      "misc-text-beside-icons"            = false;
      "shortcuts-icon-size"               = "THUNAR_ICON_SIZE_16";
      "tree-icon-emblems"                 = "true";
      "shortcuts-icon-emblems"            = "true";
      "last-details-view-visible-columns" = "THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE";
      "misc-recursive-permissions"        = "THUNAR_RECURSIVE_PERMISSIONS_ALWAYS";
    };
  };
  # xsettings
  services.xsettingsd.settings = {
  };
  # Home directories
  xdg.enable = true;
  xdg.userDirs = {
    enable                = true;
    createDirectories     = true;
    desktop               = "${config.home.homeDirectory}/desktop";
    download              = "${config.home.homeDirectory}/downloads";
    documents             = "${config.home.homeDirectory}/docs";
    music                 = "${config.home.homeDirectory}/music";
    pictures              = "${config.home.homeDirectory}/pictures";
    videos                = "${config.home.homeDirectory}/videos";
    publicShare           = null;
    templates             = null;
    extraConfig = {
      XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/captures";
      XDG_CODE_DIR        = "${config.home.homeDirectory}/code";
      XDG_TORRENTS_DIR    = "${config.home.homeDirectory}/deluge";
      XDG_GAMES_DIR       = "${config.home.homeDirectory}/games";
      XDG_SHARE_DIR       = "${config.home.homeDirectory}/sync";
      XDG_TOOLS_DIR       = "${config.home.homeDirectory}/util";
      XDG_VM_DIR          = "${config.home.homeDirectory}/vm";
    };
  };
}