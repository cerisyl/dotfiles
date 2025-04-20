# Shoutouts mimvoid@github
# TODO: This is theme-contingent. Need to somehow move this into themes folder
{ config, pkgs, lib, ... }: let
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
    "icon-size"         = 24;
    "plugin-ids"        = pkgs.lib.lists.range 1 5;
  };

  # Define plugins / panel sections
  plugins = prependAttrs "plugins/plugin-" {
    # rofi / launcher
    "1"                     = "launcher";
    "1/items"               = [ "${config.home.homeDirectory}/.nix/extra/panel/rofi.desktop" ]; # TODO: Change this to a dynamic import based on theme
    "1/disable-tooltips"    = true;
    "1/show-label"          = false;

    # dockbarx
    "2"                     = "dockbarx";
    "2/block-autohide"      = false;
    "2/offset"              = 0;
    "2/max-size"            = 0;
    "2/mode"                = 2;
    "2/color"               = "rgb(16,16,16)";

    # systray
    "3"                     = "systray";
    "3/icon-size"           = 22;
    "3/square-icons"        = true;
    "3/symbolic-icons"      = true;

    # clock
    "4"                     = "clock";
    "4/mode"                = 2;
    "4/digital-time-font"   = "JetBrainsMono Nerd Font 9";
    "4/digital-layout"      = 3;
    "4/digital-time-format" = "<span line-height=\"0.85px\"><b>%l:%M:%S %p%n</b>%d %b %Y</span>";
    "4/timezone"            = "America/Chicago"; #TODO: Pass down time.timeZone somehow
    "4/tooltip-format"      = "%A, %d %B %Y";

    # genmon (show desktop)
    "5"                     = "genmon";
    "5/command"             = "sh ${config.home.homeDirectory}/.nix/extra/panel/showdesktop-wrapper.sh";
    "5/use-label"           = true;
    "5/text"                = "";
    "5/update-period"       = 86400000;
    "5/enable-single-row"   = true;
    "5/font"                = "Barlow 10";
  };
in {

  xfconf.settings.xfce4-panel = {
    "panels"            = [ 1 ];
    "panels/dark-mmode" = true;
  } // panels // plugins;
}