{ config, pkgMap, theme, getThemeFile, lib, ... }: let
  # Define theme zips
  themeZips = {
    main    = (getThemeFile "main.zip");
    icons   = (getThemeFile "icons.zip");
    cursors = (getThemeFile "cursors.zip");
  };

  # Where to unzip each type
  getTargetPath = name:
    if lib.hasPrefix "main" name then
      "${config.home.homeDirectory}/.local/share/themes/${theme}-${name}"
    else
      "${config.home.homeDirectory}/.icons/${theme}-${name}";

  # Activation commands for unzipping each
  unzipCommands = lib.concatStringsSep "\n" (lib.mapAttrsToList (name: path: ''
    mkdir -p ${lib.removeSuffix "/${name}.zip" (getTargetPath name)}
    rm -rf ${getTargetPath name}
    ${pkgMap.unzip}/bin/unzip -qq ${path} -d ${lib.removeSuffix "/${name}.zip" (getTargetPath name)}
  '') themeZips);
in {
  # Unpack zips on activation
  home.activation.installThemes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${unzipCommands}
  '';

  xfconf.settings = {
    # Session
    xfce-session = {
      "general/LockCommand" = "${pkgMap.lightdm}/bin/dm-tool lock";
    };

    # Background + desktop
    xfce4-desktop = {
      # Background
      "backdrop/screen0/monitorVirtual-1/workspace0/last-image" = (getThemeFile "img/bg.png");
      # Desktop icons
      "desktop-icons/show-tooltips"               = false;
      "desktop-icons/file-icons/show-removable"   = false;
      "desktop-icons/file-icons/show-filesystem"  = false;
      "desktop-icons/file-icons/show-trash"       = true;
      "desktop-icons/file-icons/show-home"        = true;
      "desktop-icons/show-hidden-files"           = false;
      "desktop-icons/single-click"                = true;
      "desktop-icons/font-size"                   = 9;
      "desktop-icons/icon-size"                   = 48;
    };

    # Windows
    xfwm4 = {
      "general/button_layout"     = "O|HMC";
      "general/placement_mode"    = "mouse";
      "general/scroll_workspaces" = false;
      "general/snap_width"        = 28;
      "general/theme"             = "${theme}-main";
      "general/title_alignment"   = "left";
      "general/title_font"        = "Barlow Semi-Bold 10";
      "general/toggle_workspaces" = false;
      "general/workspace_count"   = 1;
      "general/wrap_windows"      = false;
      "general/workspace_names"   = [ "main" ];
    };

    xsettings = {
      # Net
      "Net/ThemeName"                 = "${theme}-main";
      "Net/IconThemeName"             = "${theme}-icons";
      "Net/EnableEventSounds"         = true;
      "Net/EnableInputFeedbackSounds" = true;
      # Gtk
      "Gtk/ButtonImages"        = false;
      "Gtk/ColorPalette"        = "";
      "Gtk/CursorThemeName"     = "${theme}-cursors";
      "Gtk/CursorThemeSize"     = 24;
      "Gtk/FontName"            = "Barlow 10";
      "Gtk/MenuBarAccel"        = "";
      "Gtk/MonospaceFontName"   = "JetBrainsMono Nerd Font 10";
      "Gtk/TitlebarMiddleClick" = "";
      "Gtk/ToolbarIconSize"     = "";
      "Gtk/ToolbarStyle"        = "";
      # Xfce
      "Xfce/LastCustomDPI"  = 96;
      "Xfce/SyncThemes"     = true;
    };
  };

  # Home directories
  xdg = {
    enable = true;
    userDirs = {
      enable                = true;
      createDirectories     = true;
      desktop               = "${config.home.homeDirectory}/desktop";
      download              = "${config.home.homeDirectory}/downloads";
      documents             = "${config.home.homeDirectory}/docs";
      music                 = "${config.home.homeDirectory}/music";
      pictures              = "${config.home.homeDirectory}/pictures";
      videos                = "${config.home.homeDirectory}/videos";
      publicShare           = null;
      templates             = null;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/captures";
        XDG_CODE_DIR        = "${config.home.homeDirectory}/code";
        XDG_TORRENTS_DIR    = "${config.home.homeDirectory}/deluge";
        XDG_GAMES_DIR       = "${config.home.homeDirectory}/games";
        XDG_SHARE_DIR       = "${config.home.homeDirectory}/sync";
        XDG_TOOLS_DIR       = "${config.home.homeDirectory}/util";
        XDG_VM_DIR          = "${config.home.homeDirectory}/vm";
      };
    };
    # Default programs
    configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty
      WebBrowser=floorp
    '';
  };
}