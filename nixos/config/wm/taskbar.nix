# Shoutouts mimvoid@github
# TODO: This is theme-contingent. Need to somehow move this into themes folder
{ config, pkgMap, theme, getThemeFile, lib, ... }: let
  # Make life easier - prefixes a key in an attribute set
  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "${prefix}${name}" value);

  # Define panel
  panels = prependAttrs "panels/panel-1/" {
    "position-locked"   = true;
    "background-style"  = 1; # solid color
    "background-rgba"   = [ (19 / 255.0) (19 / 255.0) (22 / 255.0) 1.00 ]; #131316
    "position"          = "p=8;x=640;y=786";
    "length"            = 100;
    "size"              = 48;
    "icon-size"         = 32;
    "plugin-ids"        = [ 1 2 3 4 5 6 ];
  };

  # Define plugins / panel sections
  plugins = prependAttrs "plugins/plugin-" {
    # rofi / launcher
    "1"                     = "launcher";
    "1/items"               = [ "${config.home.homeDirectory}/.nix/extra/panel/rofi.desktop" ]; # TODO: Change this to a dynamic import based on theme
    "1/disable-tooltips"    = true;
    "1/show-label"          = false;

    # tasklist
    "2"                     = "tasklist";
    "2/show-handle"         = false;
    "2/window-scrolling"    = false;
    "2/middle-click"        = 3; # new instance
    "2/grouping"            = true;
    "2/sort-order"          = 4; # drag'n'drop
    "2/show-labels"         = false;
    "2/flat-buttons"        = false;

    # separator
    "3"                     = "separator";
    "3/expand"              = true;
    "3/style"               = 0; # transparent

    # systray
    "4"                     = "systray";
    "4/icon-size"           = 16;
    "4/square-icons"        = false;
    "4/symbolic-icons"      = true;

    # clock
    "5"                     = "clock";
    "5/mode"                = 2;
    "5/digital-time-font"   = "JetBrainsMono Nerd Font 9";
    "5/digital-layout"      = 3;
    "5/digital-time-format" = "<span line-height=\"0.85px\"><b>%l:%M:%S %p%n</b>%d %b %Y</span>";
    "5/timezone"            = "America/Chicago"; #TODO: Pass down time.timeZone somehow
    "5/tooltip-format"      = "%A, %d %B %Y";

    # genmon (show desktop)
    "6"                     = "genmon";
    "6/command"             = "sh ${config.home.homeDirectory}/.nix/extra/panel/showdesktop-wrapper.sh";
    "6/use-label"           = true;
    "6/text"                = "";
    "6/update-period"       = 86400000;
    "6/enable-single-row"   = true;
    "6/font"                = "Barlow 10";
  };
in {

  xfconf.settings.xfce4-panel = {
    "panels"            = [ 1 ];
    "panels/dark-mmode" = true;
  } // panels // plugins;
}