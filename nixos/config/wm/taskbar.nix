# Shoutouts mimvoid@github
{ config, pkgMap, theme, getThemeFile, timezone, homedir, myHostname, lib, ... }: let
  # Make life easier - prefixes a key in an attribute set
  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "${prefix}${name}" value);

  # Theme-specific properties
  themeProps = {
    ceres = {
      height            = 48;
      darkMode          = true;
      bgStyle           = 1; # solid color
      bgColor           = [ (19 / 255.0) (19 / 255.0) (22 / 255.0) 1.00 ]; #131316
      bgImage           = null;
      showLabels        = false;
      flatButtons       = false;
      font              = "Barlow Regular 10";
      cssStartMenu      = false;
      iconSize          = 32;
      trayIconSize      = 16;
      symbolicIcons     = false;
      clockFont         = "JetBrainsMono Nerd Font 9";
      clockDisplay      = "<span line-height=\"0.85px\"><b>%l:%M:%S %p%n</b>%d %b %Y</span>";
    };
    aero = {
      height            = 48;
      darkMode          = false;
      bgStyle           = 2; # image
      bgColor           = [ 1.00 1.00 1.00 1.00 ];
      bgImage           = "file://${homedir}/.nix/themes/aero/img/taskbar.png";
      showLabels        = false;
      flatButtons       = false;
      font              = "Segoe UI Regular 10";
      cssStartMenu      = true;
      iconSize          = 32;
      trayIconSize      = 16;
      symbolicIcons     = false;
      clockFont         = "Segoe UI Regular 9";
      clockDisplay      = "<span line-height=\"0.85px\"><b>%l:%M:%S %p%n</b>%d %b %Y</span>";
    };
    luna = {
      height            = 32;
      darkMode          = false;
      bgStyle           = 0; # n/a
      bgColor           = [ 1.00 1.00 1.00 1.00 ];
      bgImage           = null;
      showLabels        = true;
      flatButtons       = false;
      font              = "Tahoma Regular 8";
      cssStartMenu      = true;
      iconSize          = 16;
      trayIconSize      = 16;
      symbolicIcons     = false;
      clockFont         = "Verdana Regular 8";
      clockDisplay      = "<b>%l:%M:%S %p</b>";
    };
    memphis = {
      height            = 24;
      darkMode          = false;
      bgStyle           = 0; # n/a
      bgColor           = [ 1.00 1.00 1.00 1.00 ];
      bgImage           = null;
      showLabels        = true;
      flatButtons       = false;
      font              = "MS Sans Serif Regular 10";
      cssStartMenu      = true;
      iconSize          = 16;
      trayIconSize      = 16;
      symbolicIcons     = false;
      clockFont         = "JetBrainsMono Nerd Font 8";
      clockDisplay      = "<b>%l:%M:%S %p</b>";
    };
    note = {
      height            = 48;
      darkMode          = true;
      bgStyle           = 0; # n/a
      bgColor           = [ 1.00 1.00 1.00 1.00 ];
      bgImage           = null;
      showLabels        = false;
      flatButtons       = false;
      font              = "Roboto Regular 9";
      cssStartMenu      = false;
      iconSize          = 32;
      trayIconSize      = 16;
      symbolicIcons     = false;
      clockFont         = "Roboto Regular 9";
      clockDisplay      = "<span line-height=\"0.85px\"><b>%l:%M:%S %p%n</b>%d %b %Y</span>";
    };
    osx = {
      height            = 48;
      darkMode          = false;
      bgStyle           = 0; # n/a
      bgColor           = [ 1.00 1.00 1.00 1.00 ];
      bgImage           = null;
      showLabels        = false;
      flatButtons       = true;
      font              = "Helvetica Neue Regular 10";
      cssStartMenu      = false;
      iconSize          = 32;
      trayIconSize      = 16;
      symbolicIcons     = false;
      clockFont         = "JetBrainsMono Nerd Font 9";
      clockDisplay      = "<span line-height=\"0.85px\"><b>%l:%M:%S %p%n</b>%d %b %Y</span>";
    };
  };

  # Define panels
  mainPanels = prependAttrs "panels/panel-" {
    "1/output-name"       = "Primary";
    "1/position"          = "p=8;x=640;y=786";
    "1/position-locked"   = true;
    "1/background-style"  = themeProps."${theme}".bgStyle;
    "1/background-rgba"   = themeProps."${theme}".bgColor;
    "1/length"            = 100;
    "1/size"              = themeProps."${theme}".height;
    "1/icon-size"         = themeProps."${theme}".iconSize;
    "1/plugin-ids"        = [ 1 2 3 4 5 6 ];
  };

  # For multiple displays
  extraPanels = if myHostname == "engrit" then prependAttrs "panels/panel-" {
    "2/output-name"       = "DP-1-2";
    "2/position"          = "p=8;x=2688;y=1413";
    "2/position-locked"   = true;
    "2/background-style"  = themeProps."${theme}".bgStyle;
    "2/background-rgba"   = themeProps."${theme}".bgColor;
    "2/length"            = 100;
    "2/size"              = themeProps."${theme}".height;
    "2/icon-size"         = themeProps."${theme}".iconSize;
    "2/plugin-ids"        = [ 1 2 3 4 5 6 ];
  } else {};

  # Define plugins / panel sections
  startMenuFile = "${if themeProps."${theme}".cssStartMenu != true then "rofi" else "rofi-alt"}.desktop";
  plugins = prependAttrs "plugins/plugin-" {
    # rofi / start menu / launcher
    "1"                     = "launcher";
    "1/items"               = [ "${homedir}/.nix/extra/panel/${startMenuFile}" ];
    "1/disable-tooltips"    = true;
    "1/show-label"          = false;

    # tasklist
    "2"                     = "tasklist";
    "2/show-labels"         = themeProps."${theme}".showLabels;
    "2/show-handle"         = false;
    "2/window-scrolling"    = false;
    "2/middle-click"        = 3; # new instance
    "2/grouping"            = true;
    "2/sort-order"          = 4; # drag'n'drop
    "2/flat-buttons"        = themeProps."${theme}".flatButtons;

    # separator
    "3"                     = "separator";
    "3/expand"              = true;
    "3/style"               = 0; # transparent

    # systray
    "4"                     = "systray";
    "4/icon-size"           = themeProps."${theme}".trayIconSize;
    "4/square-icons"        = false;
    "4/single-row"          = true;
    "4/menu-is-primary"     = false;
    "4/symbolic-icons"      = themeProps."${theme}".symbolicIcons;
    # order of icons (legacy, hidden)
    ### chrome_status_icon_1 = discord
    ### electron = teams
    "4/hidden-legacy-items" = [                                                                          "deluge" ];
    "4/known-legacy-items"  = [ "networkmanager applet" "volume" ".volctl-wrapped" "xfce4-power-manager" "deluge" ];
    "4/hidden-items"        = [                              "dropbox" "blueman" "chrome_status_icon_1" "steam" "TelegramDesktop" "electron" "slack" "vlc" "obs" ];
    "4/known-items"         = [ "KeePassXC" "Syncthing Tray" "dropbox" "blueman" "chrome_status_icon_1" "steam" "TelegramDesktop" "electron" "slack" "vlc" "obs" ];

    # clock
    "5"                     = "clock";
    "5/mode"                = 2;
    "5/digital-time-font"   = themeProps."${theme}".clockFont;
    "5/digital-layout"      = 3;
    "5/digital-time-format" = themeProps."${theme}".clockDisplay;
    "5/timezone"            = timezone;
    "5/tooltip-format"      = "%A, %d %B %Y";

    # genmon (show desktop)
    "6"                     = "genmon";
    "6/command"             = "sh ${homedir}/.nix/extra/panel/showdesktop-wrapper.sh";
    "6/use-label"           = true;
    "6/text"                = "";
    "6/update-period"       = 86400000;
    "6/enable-single-row"   = true;
    "6/font"                = themeProps."${theme}".font;
  };
in {

  xfconf.settings.xfce4-panel = {
    "panels"            = [ 1 ];
    "panels/dark-mode"  = themeProps."${theme}".darkMode;
  } // mainPanels // extraPanels // plugins;
}