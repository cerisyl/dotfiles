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

  # Define plugins / panel sections
  startMenuFile = "${if themeProps."${theme}".cssStartMenu != true then "rofi" else "rofi-alt"}.desktop";

  # Plugins---------------------------------------------------------------------

  # rofi / start menu / launcher
  rofi = id: prependAttrs "plugins/plugin-${id}" {
    ""                  = "launcher";
    "/items"            = [ "${homedir}/.nix/extra/panel/${startMenuFile}" ];
    "/disable-tooltips" = true;
    "/show-label"       = false;
  };

  # tasklist
  tasklist = id: prependAttrs "plugins/plugin-${id}" {
    ""                  = "tasklist";
    "/show-labels"      = themeProps."${theme}".showLabels;
    "/show-handle"      = false;
    "/window-scrolling" = false;
    "/middle-click"     = 3; # new instance
    "/grouping"         = true;
    "/sort-order"       = 4; # drag'n'drop
    "/flat-buttons"     = themeProps."${theme}".flatButtons;
  };

  # separator
  separator = id: prependAttrs "plugins/plugin-${id}" {
    ""                  = "separator";
    "/expand"           = true;
    "/style"            = 0; # transparent
  };

  # systray
  systray = id: prependAttrs "plugins/plugin-${id}" {
    ""                  = "systray";
    "/icon-size"        = themeProps."${theme}".trayIconSize;
    "/square-icons"     = false;
    "/single-row"       = true;
    "/menu-is-primary"  = false;
    "/symbolic-icons"   = themeProps."${theme}".symbolicIcons;
    # order of icons (legacy, hidden)
    ### chrome_status_icon_1 = discord
    ### electron = teams
    "/hidden-legacy-items"  = [                                                                          "deluge" ];
    "/known-legacy-items"   = [ "networkmanager applet" "volume" ".volctl-wrapped" "xfce4-power-manager" "deluge" ];
    "/hidden-items"         = [                              "dropbox" "blueman" "chrome_status_icon_1" "steam" "TelegramDesktop" "electron" "slack" "remmina-icon" "zoom" "vlc" "obs" ];
    "/known-items"          = [ "KeePassXC" "Syncthing Tray" "dropbox" "blueman" "chrome_status_icon_1" "steam" "TelegramDesktop" "electron" "slack" "remmina-icon" "zoom" "vlc" "obs" ];
  };

  # clock
  clock = id: prependAttrs "plugins/plugin-${id}" {
    ""                     = "clock";
    "/mode"                = 2;
    "/digital-time-font"   = themeProps."${theme}".clockFont;
    "/digital-layout"      = 3;
    "/digital-time-format" = themeProps."${theme}".clockDisplay;
    "/timezone"            = timezone;
    "/tooltip-format"      = "%A, %d %B %Y";
  };

  # genmon (show desktop)
  genmon = id: prependAttrs "plugins/plugin-${id}" {
    ""                     = "genmon";
    "/command"             = "sh ${homedir}/.nix/extra/panel/showdesktop-wrapper.sh";
    "/use-label"           = true;
    "/text"                = "";
    "/update-period"       = 86400000;
    "/enable-single-row"   = true;
    "/font"                = themeProps."${theme}".font;
  };

  #-----------------------------------------------------------------------------

  # Define panels
  mainPanel = prependAttrs "panels/panel-" {
    "1/output-name"       = "Primary";
    "1/position"          = "p=8;x=640;y=786";
    "1/position-locked"   = true;
    "1/background-style"  = themeProps."${theme}".bgStyle;
    "1/background-rgba"   = themeProps."${theme}".bgColor;
    "1/length"            = 100;
    "1/size"              = themeProps."${theme}".height;
    "1/icon-size"         = themeProps."${theme}".iconSize;
    "1/plugin-ids"        = [ 1 2 3 4 5 6 ];
  } // rofi "1" // tasklist "2" // separator "3" // systray "4" // clock "5" // genmon "6";

  # For multiple displays
  extraPanel = if myHostname == "engrit" then prependAttrs "panels/panel-" {
    "2/output-name"       = "DP-1-2";
    "2/position"          = "p=8;x=2688;y=1413";
    "2/position-locked"   = true;
    "2/background-style"  = themeProps."${theme}".bgStyle;
    "2/background-rgba"   = themeProps."${theme}".bgColor;
    "2/length"            = 100;
    "2/size"              = themeProps."${theme}".height;
    "2/icon-size"         = themeProps."${theme}".iconSize;
    "2/plugin-ids"        = [ 7 8 9 10 11 ];
  } // rofi "7" // tasklist "8" // separator "9" // clock "10" // genmon "11" else {};
in {
  xfconf.settings.xfce4-panel = {
    "panels"            = [ 1 ] ++ (if myHostname == "engrit" then [ 2 ] else [ ]);
    "panels/dark-mode"  = themeProps."${theme}".darkMode;
  } // mainPanel // extraPanel;
}