{ config, pkgMap, theme, getThemeFile, homedir, myHostname, lib, ... }: {
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
      "trash:///"
      "recent:///"
      "network:///"
    ];
  };

  xdg.configFile = {
    # Bookmarks
    "gtk-3.0/bookmarks".text = ''
      file://${homedir}/captures
      file://${homedir}/code
      file://${homedir}/docs
      file://${homedir}/downloads
      file://${homedir}/games
      ${if myHostname != "astore" then "file://${homedir}/itg" else ""}
      file://${homedir}/music
      file://${homedir}/pictures
      ${if myHostname == "lux" then "file://${homedir}/.itgmania/Screenshots screenshots-itg" else ""}
      file://${homedir}/sync
      file://${homedir}/util
      file://${homedir}/videos
      ${if myHostname != "astore" then "sftp://192.168.200.240:50951/home/ceri astore" else ""}
    '';

    # Folder shortcuts
    "Thunar/uca.xml".text = ''
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
        <icon>vscode</icon>
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
  };
}