# Shoutouts mimvoid@github
# TODO: This is theme-contingent. Need to somehow move this into themes folder
{ config, pkgMap, theme, getThemeFile, timezone, homedir, lib, ... }: let
  # Make life easier - prefixes a key in an attribute set
  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "${prefix}${name}" value);

  # Theme-specific properties
  themeProps = {
    ceres = {
      height            = 48;
      darkMode          = true;
      bgStyle           = 1; # solid color;
      bgColor           = [ (19 / 255.0) (19 / 255.0) (22 / 255.0) 1.00 ]; #131316
      bgImage           = null;
      showLabels        = false;
      flatButtons       = false;
      font              = "Barlow Regular 10";
      iconSize          = 32;
      trayIconSize      = 16;
      symbolicIcons     = false;
    };
    aero = {
      height            = 48;
      darkMode          = false;
      bgStyle           = 2; # image;
      bgColor           = [ 1.00 1.00 1.00 1.00 ];
      bgImage           = "file://${homedir}/.nix/themes/aero/img/taskbar.png";
      showLabels        = false;
      flatButtons       = false;
      font              = "Segoe UI Regular 10";
      iconSize          = 32;
      trayIconSize      = 22;
      symbolicIcons     = true;
    };
    luna = {
      height            = 28;
      darkMode          = false;
      bgStyle           = 0; # n/a;
      bgColor           = [ (30 / 255.0) (93 / 255.0) (220 / 255.0) 1.00 ]; #1e5ddc
      bgImage           = null;
      showLabels        = true;
      flatButtons       = false;
      font              = "Tahoma Regular 8";
      iconSize          = 16;
      trayIconSize      = 16;
      symbolicIcons     = false;
    };
  };

  # Define panel
  panels = prependAttrs "panels/panel-1/" {
    "position-locked"   = true;
    "background-style"  = themeProps."${theme}".bgStyle;
    "background-rgba"   = themeProps."${theme}".bgColor;
    "position"          = "p=8;x=640;y=786";
    "length"            = 100;
    "size"              = themeProps."${theme}".height;
    "icon-size"         = themeProps."${theme}".iconSize;
    "plugin-ids"        = [ 1 2 3 4 5 6 ];
  };

  # Define plugins / panel sections
  plugins = prependAttrs "plugins/plugin-" {
    # rofi / launcher
    "1"                     = "launcher";
    "1/items"               = [ "${homedir}/.nix/extra/panel/rofi.desktop" ];
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
    # chrome_status_icon_1 -> discord/vesktop
    "4/hidden-legacy-items" = [ "deluge" ];
    "4/known-legacy-items"  = [ "deluge" "networkmanager applet" ];
    "4/hidden-items"        = [ "chrome_status_icon_1" "vlc" "obs" ];
    "4/known-items"         = [ "pasystray" "KeePassXC" "chrome_status_icon_1" "vlc" "obs" ];

    # clock
    "5"                     = "clock";
    "5/mode"                = 2;
    "5/digital-time-font"   = "JetBrainsMono Nerd Font 9";
    "5/digital-layout"      = 3;
    "5/digital-time-format" = "<span line-height=\"0.85px\"><b>%l:%M:%S %p%n</b>%d %b %Y</span>";
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
  } // panels // plugins;
}