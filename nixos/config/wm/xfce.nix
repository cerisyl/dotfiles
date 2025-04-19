{ config, pkgs, lib, ... }: let
  # Extract a theme
  getTheme = name: zipFile: pkgs.runCommand name {
    buildInputs = [ pkgs.unzip ];
  } ''
    mkdir -p $out
    unzip -qq ${zipFile} -d $out
  '';

  # Define themes
  themeZip    = getTheme "main" ../../../themes/ceres/main.zip;
  iconsZip    = getTheme "icons" ../../../themes/ceres/icons.zip;
  cursorsZip  = getTheme "cursors" ../../../themes/ceres/cursors.zip;
in {
  home.file = {
    # XFCE/GTK theme
    ".local/share/themes/ceres" = {
      source = themeZip;
      recursive = true;
    };
    # Icons
    ".icons/ceres-icons" = {
      source = iconsZip;
      recursive = true;
    };
    # Cursors
    ".icons/ceres-cursors" = {
      source = cursorsZip;
      recursive = true;
    };
  };

  xfconf.settings = {
    # Session
    xfce-session = {
      "general/LockCommand" = "${pkgs.lightdm}/bin/dm-tool lock";
    };

    # Background + desktop
    xfce4-desktop = {
      # Background
      "backdrop/screen0/monitorVirtual-1/workspace0/last-image" = "${config.home.homeDirectory}/.nix/themes/ceres/img/bg.png";
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

    # TODO: Keyboard shortcuts
    xfce4-keyboard-shortcuts = {
    };

    # Windows
    xfwm4 = {
      "general/button-layout"     = "O|HMC";
      "general/placement_mode"    = "mouse";
      "general/scroll-workspaces" = false;
      "general/snap-width"        = 28;
      "general/theme"             = "main";
      "general/title-alignment"   = "left";
      "general/title-font"        = "Barlow Semi-Bold 10";
      "general/toggle_workspaces" = false;
      "general/workspace_count"   = 1;
      "general/wrap_windows"      = false;
      "general/workspace_names"   = [ "main" ];
    };
  };

  services.xsettingsd = {
    enable = true;
    # Net
    "Net/ThemeName"                 = "main";
    "Net/IconThemeName"             = "icons";
    "Net/EnableEventSounds"         = true;
    "Net/EnableInputFeedbackSounds" = true;
    # Gtk
    "Gtk/ButtonImages"        = false;
    "Gtk/ColorPalette"        = "";
    "Gtk/CursorThemeName"     = "cursors";
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