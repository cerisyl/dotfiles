# Shoutouts mimvoid@github
# TODO: This is theme-contingent. Need to somehow move this into themes folder
{ config, pkgs, lib, ... }: let
  # Make life easier
  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "${prefix}${name}" value);

  # Define panel
  panels = prependAttrs "panels/panel-1/" {
    "position-locked"   = true;
    "background-style"  = 1; # solid color
    "background-rgba"   = [ (19 / 255.0) (19 / 255.0) (22 / 255.0) 1 ]; #131316
    "position"          = "p=8;x=640;y=786";
    "length"            = 100;
    "size"              = 48;
    "icon-size"         = 24;
    "plugin-ids"        = pkgs.lib.lists.range 1 6;
  };

  # Define plugins / panel sections
  plugins = prependAttrs "plugins/plugin-" {
    # rofi / launcher
    "1"                     = "launcher";
    "1/items"               = "${config.home.homeDirectory}/.nix/extra/panel/rofi.desktop";
    "1/disable-tooltips"    = true;
    "1/show-label"          = false;

    # separator
    "2"                     = "separator";
    "2/style"               = 0; # transparent
    "2/expand"              = true;

    # dockbarx
    "3"                     = "dockbarx";
    "3/block-autohide"      = false;
    "3/offset"              = 0;
    "3/max-size"            = 0;
    "3/mode"                = 2;
    "3/color"               = "rgb(16,16,16)";

    # systray
    "4"                     = "systray";
    "4/icon-size"           = 22;
    "4/square-icons"        = true;
    "4/symbolic-icons"      = true;

    # clock
    "5"                     = "clock";
    "5/mode"                = 2;
    "5/digital-date-font"   = "Barlow 11";
    "5/digital-time-font"   = "JetBrainsMonoNL Nerd Font 9";
    "5/digital-time-format" = "&lt;span line-height=&quot;0.85px&quot;&gt;&lt;b&gt;%l:%M:%S %p%n&lt;/b&gt;%d %b %Y&lt;/span&gt;";
    "5/digital-date-format" = "%d %b %Y";
    "5/digital-layout"      = "3";
    "5/timezone"            = time.timeZone;
    "5/tooltip-format"      = "%A, %d %B %Y";

    # genmon (show desktop)
    "6"                     = "genmon";
    "6/command"             = "sh ${config.home.homeDirectory}/.nix/extra/showdesktop-wrapper.sh";
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