{ config, pkgMap, theme, getThemeFile, homedir, myHostname, lib, ... }: let

  # TODO: Pull this from main config file- possibly see if this is syncable with the init defined in /packages
  # maybe it could be an extra option in pkgMap...
  hostMap = {
    "lux"     = "l";
    "nova"    = "n";
    "vm"      = "n";
    "astore"  = "a";
    "medea"   = "m";
    "engrit"  = "e";
  };
  hostID = hostMap.${myHostname};
  toInit = str: (lib.strings.hasInfix hostID str);

  # Create and/or bookmark directories based on hostname
  mkPlace = init: path: alias:
    if (toInit init == true) then {
      dirs = {};
      places = [ (if alias == true then path else "${path} ${alias}") ];
    } else { dirs = {}; places = []; };

  mkDir = init: path: type: place: isExtra:
    if (toInit init == true) then
      let
        realType = if type == true then path else type;
        dirs = if isExtra == true
          then { extraConfig."XDG_${lib.toUpper realType}_DIR" = "${homedir}/${path}"; }
          else { "${realType}" = "${homedir}/${path}"; };
        places = if place == true
          then [ "file://${homedir}/${path}" ]
          else [];
      in { inherit dirs places; }
    else { dirs = {}; places = []; };

  userDirs = [
    #cmd      init    path          type          place     isExtra     place:alias
    (mkDir    "lname" "captures"    "screenshots" true      true)
    (mkDir    "lname" "code"        true          true      true)
    (mkDir    "lname" "desktop"     true          false     false)
    (mkDir    "lnam." "deluge"      "torrents"    false     true)
    (mkDir    "lname" "docs"        "documents"   true      false)
    (mkPlace  "l...." "file://${homedir}/Dropbox"                       "dropbox")
    (mkDir    "lname" "downloads"   "download"    true      false)
    (mkDir    "lna.." "games"       true          true      true)
    (mkDir    "ln..." "itg"         true          true      true)
    (mkDir    "lname" "music"       true          true      false)
    (mkPlace  "....e" "file://${homedir}/OneDrive"                      "onedrive")
    (mkDir    "lname" "pictures"    true          true      false)
    (mkPlace  "l...." "file://${homedir}/.itgmania/Screenshots"         "screenshots-itg")
    (mkPlace  "l...." "file:///mnt/share"  "share")
    (mkDir    "lname" "sync"        true          true      true)
    (mkDir    "lname" "util"        "tools"       true      true)
    (mkDir    "lname" "vm"          true          false     true)
    (mkDir    "lname" "videos"      true          true      false)
    # external/network locations
    (mkPlace  "l...." "file:///mnt/astore" "astore")
    (mkPlace  "l...." "file:///mnt/extra"  "extra")
    (mkPlace  "....e" "smb://sgunning@engrit-file-01.ad.uillinois.edu/engrit/Shares/admin/Building%20Maps"  "maps")
    (mkPlace  "....e" "smb://sgunning@engr-archive.ad.uillinois.edu/Archive/Microsoft/Windows/OS/ISOs"      "isos")
  ];

  # Parse the defined list
  filtered = lib.foldl' (acc: entry: {
    dirs = acc.dirs // entry.dirs;
    places = acc.places ++ entry.places;
  }) { dirs = {}; places = []; } userDirs;

in {
  # Directories, bookmarks/places, and context menu shortcuts
  xdg = {
    userDirs = filtered.dirs;
    configFile  = {
      "gtk-3.0/bookmarks".text = lib.concatStringsSep "\n" filtered.places;
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
        <action>
          <icon>engrampa</icon>
          <name>Compress to ZIP</name>
          <submenu></submenu>
          <unique-id>1752110568612037-1</unique-id>
          <command>zip -r %n.zip %F</command>
          <description>Recursively sends selected files to a ZIP</description>
          <range>*</range>
          <patterns>*</patterns>
	        <directories/>
	        <audio-files/>
	        <image-files/>
	        <other-files/>
	        <text-files/>
	        <video-files/>
        </action>
        <action>
          <icon>engrampa</icon>
          <name>Compress to 7z</name>
          <submenu></submenu>
          <unique-id>1752110568612037-1</unique-id>
          <command>7z a %n.7z %F</command>
          <description>Recursively sends selected files to a 7z</description>
          <range>*</range>
          <patterns>*</patterns>
	        <directories/>
	        <audio-files/>
	        <image-files/>
	        <other-files/>
	        <text-files/>
	        <video-files/>
        </action>
        </actions>
      '';
    };
  };

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
    #last-details-view-column-widths   = "50,50,185,104,50,158,50,50,291,50,50,64,50,694";
    misc-recursive-permissions        = "THUNAR_RECURSIVE_PERMISSIONS_ALWAYS";
    misc-date-style                   = "THUNAR_DATE_STYLE_CUSTOM";
    misc-date-custom-style            = "%Y-%m-%d %I:%M %p";
    hidden-bookmarks                  = [ "trash:///" "recent:///" "network:///" ];
    hidden-devices                    = [
      "192.168.200.240"
      smb://sgunning@engrit-file-01.ad.uillinois.edu/archive
      smb://sgunning@engr-archive.ad.uillinois.edu/engrit
    ];
  };
}