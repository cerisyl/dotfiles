{ config, pkgMap, theme, getThemeFile, homedir, lib, ... }: let
  # Define theme zips
  # Add window.zip to themeZips, if it exists
  themeZips = {
    main    = (getThemeFile "main.zip");
    icons   = (getThemeFile "icons.zip");
    cursors = (getThemeFile "cursors.zip");
  } // (if builtins.pathExists ../../../themes + "/${theme}/windows.zip"
  then { window = (getThemeFile "cursors.zip"); } else {});

  # Where to unzip each type
  getTargetPath = name:
    if (lib.hasPrefix "main" name) || (lib.hasPrefix "window" name) then
      "${homedir}/.local/share/themes/${theme}-${name}"
    else
      "${homedir}/.icons/${theme}-${name}";

  # Activation commands for unzipping each theme
  unzipCommands = lib.concatStringsSep "\n" (lib.mapAttrsToList (name: path: ''
    mkdir -p ${lib.removeSuffix "/${name}.zip" (getTargetPath name)}
    rm -rf ${getTargetPath name}
    ${pkgMap.unzip}/bin/unzip -qq ${path} -d ${lib.removeSuffix "/${name}.zip" (getTargetPath name)}
  '') themeZips);

  # Theme-specific properties
  themeProps = {
    ceres = {
      font              = "Barlow Regular 10";
      fontTitle         = "Barlow Semi-Bold 10";
      desktopFontSize   = 9;
      cursorSize        = 24;
      dpi               = 96;
      syncThemes        = true;
      windowTitleAlign  = "left";
      windowTheme       = "${theme}-main";
    };
    aero = {
      font              = "Segoe 10";
      fontTitle         = "Segoe 9";
      desktopFontSize   = 9;
      cursorSize        = 24;
      dpi               = 98;
      syncThemes        = false;
      windowTitleAlign  = "left";
      windowTheme       = "${theme}-window";
    };
  };

in {
  # Unpack zips on activation
  home.activation.installThemes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${unzipCommands}
  '';

  # Remove backup files on activation
  home.activation.removeBackups = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgMap.fd}/bin/fd -H ".*\.63a4305d$" ~ -X rm
  '';

  xfconf.settings = {
    # Session
    xfce-session = {
      "general/LockCommand" = "${pkgMap.lightdm}/bin/dm-tool lock";
    };

    # Disable screensaver
    xfce4-screensaver = {
      "saver/enabled" = false;
      "saver/idle-activation/enabled" = false;
    };

    # Background + desktop
    xfce4-desktop = {
      # Background
      "backdrop/screen0/monitorVirtual-1/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
      # Desktop icons
      "desktop-icons/show-tooltips"               = false;
      "desktop-icons/file-icons/show-removable"   = false;
      "desktop-icons/file-icons/show-filesystem"  = false;
      "desktop-icons/file-icons/show-trash"       = true;
      "desktop-icons/file-icons/show-home"        = true;
      "desktop-icons/show-hidden-files"           = false;
      "desktop-icons/single-click"                = true;
      "desktop-icons/font-size"                   = themeProps."${theme}".desktopFontSize;
      "desktop-icons/icon-size"                   = 48;
    };

    # Windows
    xfwm4 = {
      "general/button_layout"     = "O|HMC";
      "general/placement_mode"    = "mouse";
      "general/scroll_workspaces" = false;
      "general/snap_width"        = 28;
      "general/theme"             = themeProps."${theme}".windowTheme; # Window theme
      "general/title_alignment"   = themeProps."${theme}".windowTitleAlign;
      "general/title_font"        = themeProps."${theme}".fontTitle;
      "general/toggle_workspaces" = false;
      "general/workspace_count"   = 1;
      "general/wrap_windows"      = false;
      "general/workspace_names"   = [ "main" ];
    };

    xsettings = {
      # Net
      "Net/ThemeName"                 = "${theme}-main"; # General theme
      "Net/IconThemeName"             = "${theme}-icons";
      "Net/EnableEventSounds"         = true;
      "Net/EnableInputFeedbackSounds" = true;
      # Gtk
      "Gtk/ButtonImages"        = false;
      "Gtk/ColorPalette"        = "";
      "Gtk/CursorThemeName"     = "${theme}-cursors";
      "Gtk/CursorThemeSize"     = 24;
      "Gtk/FontName"            = themeProps."${theme}".font;
      "Gtk/MenuBarAccel"        = "";
      "Gtk/MonospaceFontName"   = "JetBrainsMono Nerd Font 10";
      "Gtk/TitlebarMiddleClick" = "";
      "Gtk/ToolbarIconSize"     = "";
      "Gtk/ToolbarStyle"        = "";
      # Xfce
      "Xfce/LastCustomDPI"      = themeProps."${theme}".dpi;
      "Xfce/SyncThemes"         = themeProps."${theme}".syncThemes;
      # Xft
      "Xft/DPI"                 = themeProps."${theme}".dpi;
      "Xft/Antialias"           = 1; # On
      "Xft/Hinting"             = 1; # On
      "Xft/HintStyle"           = "hinfull";
    };
  };

  # Home directories
  xdg = {
    enable = true;
    userDirs = {
      enable                = true;
      createDirectories     = true;
      desktop               = "${homedir}/desktop";
      download              = "${homedir}/downloads";
      documents             = "${homedir}/docs";
      music                 = "${homedir}/music";
      pictures              = "${homedir}/pictures";
      videos                = "${homedir}/videos";
      publicShare           = null;
      templates             = null;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${homedir}/captures";
        XDG_CODE_DIR        = "${homedir}/code";
        XDG_TORRENTS_DIR    = "${homedir}/deluge";
        XDG_GAMES_DIR       = "${homedir}/games";
        XDG_SHARE_DIR       = "${homedir}/sync";
        XDG_TOOLS_DIR       = "${homedir}/util";
        XDG_VM_DIR          = "${homedir}/vm";
      };
    };
  };
}