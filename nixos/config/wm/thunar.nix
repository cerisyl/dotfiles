{ config, pkgMap, theme, getThemeFile, homedir, myHostname, lib, ... }: let

  # TODO: Pull this from main config file- possibly see if this is syncable with the init defined in /packages
  # maybe it could be an extra option in pkgMap...
  hostIndexMap = {
    "lux"     = 3;
    "nova"    = 2;
    "vm"      = 2;
    "engrit"  = 1;
    "astore"  = 0;
  };
  hostIndex = hostIndexMap.${myHostname};
  toInit = str: (builtins.stringLength str > hostIndex && builtins.substring hostIndex 1 str == "1");

  # Create and/or bookmark directories based on hostname
  mkBookmark = init: path: alias: (
    if toInit == true then
      let bookmarkEntry = if alias == true
        then path
        else "${path} ${alias}";
      in [ bookmarkEntry ]
    else []
  );

  mkDir = init: path: type: bookmark: isExtra:
    if toInit then
      let
        dirEntry = if isExtra == true
          then { extraConfig."XDG_${lib.toUpper type}_DIR" = "${homedir}/${path}"; }
          else { "${key}" = "${homedir}/${path}"; };
        bmEntry = if bookmark == true
          then (mkBookmark init "file://${homedir}/${path}" true)
          else [];
      in { inherit dirEntry bmEntry; }
    else { dirEntry = {}; bmEntry = []; };

  userDirs = [
    #cmd        init    path          type          bookmark  isExtra         bookmark:alias
    (mkDir      "1111"  "captures"    "screenshots" true      true)
    (mkDir      "1111"  "code"        true          true      true)
    (mkDir      "1111"  "desktop"     true          true      false)
    (mkDir      "1011"  "deluge"      "torrents"    false     true)
    (mkDir      "1111"  "downloads"   "downloads"   true      false)
    (mkDir      "1111"  "docs"        "docs"        true      false)
    (mkDir      "1011"  "games"       true          true      true)
    (mkBookmark "0011"  "itg"                                                 true)
    (mkDir      "1111"  "music"       true          true      false)
    (mkDir      "1111"  "pictures"    true          true      false)
    (mkBookmark "0001"  ".itgmania/Screenshots"                               "screenshots-itg")
    (mkDir      "1111"  "sync"        true          true      true)
    (mkDir      "1111"  "util"        "tools"       true      true)
    (mkDir      "1111"  "vm"          true          false     true)
    (mkDir      "1111"  "videos"      true          true      false)
    # network locations
    # TODO: engrit - Test if mounting w/out CIFS works
    (mkBookmark "0011"  "sftp://192.168.200.240:50951/home/ceri"              "astore")
    (mkBookmark "0100"  "//engrit-file-01/engrit/Shares/admin/Building Maps"  "maps")
    (mkBookmark "0100"  "//engr-archive/Archive/Microsoft/Windows/OS/ISOs"    "isos")
  ];

  # Parse the defined list
  filtered = lib.foldl' (acc: entry:
    let
      dirs = acc.dirs;
      bookmarks = acc.bookmarks;
    in
      if lib.isAttrs entry && entry ? dirsEntry then {
        dirs = dirs // entry.dirsEntry;
        bookmarks = bookmarks ++ entry.bookmarkEntry;
      } else if lib.isList entry then {
        dirs = dirs;
        bookmarks = bookmarks ++ entry;
      } else acc
  ) { dirs = {}; bookmarks = []; } myUserDirs;

in {
  xfconf.settings.xdg.userDirs            = filtered.dirs;
  xdg.configFile."gtk-3.0/bookmarks".text = lib.concatStringsSep "\n" filtered.bookmarks;

  # Viewer/interactivity settings
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
    last-details-view-column-widths   = "50,50,185,104,50,158,50,50,291,50,50,64,50,694";
    misc-recursive-permissions        = "THUNAR_RECURSIVE_PERMISSIONS_ALWAYS";
    misc-date-style                   = "THUNAR_DATE_STYLE_CUSTOM";
    misc-date-custom-style            = "%Y-%m-%d %I:%M %p";
    hidden-bookmarks                  = [ "trash:///" "recent:///" "network:///" ];
    hidden-devices                    = [ "192.168.200.240" ];
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
}