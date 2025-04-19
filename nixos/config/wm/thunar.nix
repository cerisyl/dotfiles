{ config, pkgs, lib, ... }: {
  # Default settings
  xfconf.settings.thunar = {
    last-separator-position           = 160;
    last-details-view-zoom-level      = "THUNAR_ZOOM_LEVEL_25_PERCENT";
    last-sort-column                  = "THUNAR_COLUMN_NAME";
    last-sort-order                   = "GTK_SORT_ASCENDING";
    misc-single-click                 = true;
    misc-thumbnail-draw-frames        = false;
    misc-text-beside-icons            = false;
    shortcuts-icon-size               = "THUNAR_ICON_SIZE_16";
    tree-icon-emblems                 = "true";
    shortcuts-icon-emblems            = "true";
    last-details-view-visible-columns = "THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE";
    misc-recursive-permissions        = "THUNAR_RECURSIVE_PERMISSIONS_ALWAYS";
    hidden-bookmarks = [
      "file:///${config.home.homeDirectory}/desktop"
      "trash:///"
      "recent:///"
      "network:///"
    ];
  };

  # Bookmarks
  gtk.gtk3.bookmarks = {
    "file:///${config.home.homeDirectory}/captures"
    "file:///${config.home.homeDirectory}/code"
    "file:///${config.home.homeDirectory}/desktop"
    "file:///${config.home.homeDirectory}/docs"
    "file:///${config.home.homeDirectory}/downloads"
    "file:///${config.home.homeDirectory}/games"
    "file:///${config.home.homeDirectory}/music"
    "file:///${config.home.homeDirectory}/pictures"
    "file:///${config.home.homeDirectory}/sync"
    "file:///${config.home.homeDirectory}/util"
    "file:///${config.home.homeDirectory}/videos"
  };

  # Folder shortcuts
  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
    <action>
      <icon>utilities-terminal</icon>
      <name>Open Terminal Here</name>
      <submenu></submenu>
      <unique-id>1724779490245433-1</unique-id>
      <command>exo-open --working-directory %f --launch TerminalEmulator</command>
      <description>Opens in terminal</description>
      <range></range>
      <patterns>*</patterns>
      <startup-notify/>
      <directories/>
    </action>
    <action>
      <icon>visual-studio-code</icon>
      <name>Open Folder as VS Code Project</name>
      <submenu></submenu>
      <unique-id>1725554266135535-1</unique-id>
      <command>code %f</command>
      <description>Opens folder in VS Code</description>
      <range>*</range>
      <patterns>*</patterns>
      <directories/>
    </action>
    </actions>
  '';
}