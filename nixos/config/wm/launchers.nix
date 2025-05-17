{ config, pkgMap, theme, getThemeFile, myHostname, lib, ... }: let
  removeLaunchers = [
    "btop"
    "cups"
    "kitty"
    "micro"
    "nixos-manual"
    "org.pulseaudio.pavucontrol"
    "panel-preferences"
    "thunar"
    "thunar-bulk-rename"
    "thunar-settings"
    "syncthing-ui"
    "syncthingtray"
    "volctl"
    "winetricks"
    "XColor"
    "xfce4-about"
    "xfce-backdrop-settings"
    "xfce4-notifyd-config"
    "xfce4-screensaver-preferences"
    "xfce-wm-settings"
    "xfce-wmtweaks-settings"
    "xfce-workspaces-settings"
    "xfce4-screenshooter"
  ];
  mappedRemovals = builtins.listToAttrs (map (name: {
    inherit name;
    exec = name;
    value = {
      inherit name;
      noDisplay = true;
    };
  }) removeLaunchers);

  custom = name: filename: exec: icon: { inherit name filename exec icon; };
  customLaunchers = [
    #custom Name,                     .desktop file,                    Exec (true if == .desktop file),    icon (true if == .desktop file)
    (custom "lock"                    "Lock"                            "xflock4"                           true)
    (custom "Restart"                 "restart"                         "reboot"                            "reboot")
    (custom "Shutdown"                "shutdown"                        "shutdown now"                      true)
    (custom "Discord Chat Exporter"   "discordchatexporter"             true                                "cord")
    (custom "Deluge"                  "deluge"                          true                                true)
    (custom "ITGmania"                "itgmania"                        (nvidia "itgmania")                 "itg")
    (custom "Minecraft"               "org.prismlauncher.PrismLauncher" "prismlauncher"                     "mc")
    (custom "OBS Studio"              "com.obsproject.Studio"           "obs"                               "obs")
    (custom "Kdenlive"                "org.kde.kdenlive"                "kdenlive"                          "kden")
    (custom "Steam"                   "steam"                           true                                true)
    (custom "VLC Media Player"        "vlc"                             true                                "media")
    (custom "Tauon"                   "tauonmb"                         "tauon"                             "music")
    (custom "Virtual Machine Manager" "virt-manager"                    true                                "vm")
    (custom "KeePassXC"               "org.keepassxc.KeePassXC"         "keepassxc"                         "pass")
    (custom "File Manager"            "xfce4-file-manager"              "exo-open --launch FileManager %u"  "files")
    (custom "Email"                   "thunderbird"                     true                                "email")
  ];
  mappedCustoms = builtins.listToAttrs (map (obj: {
    name = obj.filename;
    value = {
      name = obj.name;
      exec = if obj.exec == true then obj.filename else obj.exec;
      icon = if obj.icon == true then "ceri-${obj.filename}" else "ceri-${obj.icon}";
    };
  }) customLaunchers);

  # Used when removeLaunchers simply doesn't cut it.
  # These files go into .local/share/applications
  overwrite = name: filename: exec: { inherit name filename exec; };
  overwriteLaunchers = [
    #overwrite Name,                    .desktop file,                  Exec (true if == .desktop file)
    (overwrite "Accessibility"          "xfce4-accessibility-settings"  true)
    (overwrite "Appearance"             "xfce-ui-settings"              "xfce4-appearance-settings")
    (overwrite "Color Profiles"         "xfce4-color-settings"          true)
    (overwrite "Default Applications"   "xfce4-mime-settings"           true)
    (overwrite "Keyboard"               "xfce-keyboard-settings"        "xfce4-keyboard-settings")
    (overwrite "Log Out"                "xfce4-session-logout"          true)
    (overwrite "Mail Reader"            "xfce4-mail-reader"             "exo-open --launch MailReader %u")
    (overwrite "Mouse and Touchpad"     "xfce-mouse-settings"           "xfce4-mouse-settings")
    (overwrite "Session and Startup"    "xfce-session-settings"         "xfce4-session-settings")
    (overwrite "Settings Editor"        "xfce4-settings-editor"         true)
    (overwrite "Settings Manager"       "xfce4-settings-manager"        true)
    (overwrite "Web Browser"            "xfce4-web-browser"             "exo-open --launch WebBrowser %u")
    (overwrite "Rofi"                   "rofi"                          "rofi -show")
    (overwrite "Rofi Theme Selector"    "rofi-theme-selector"           true)
    (overwrite "Syncthing Tray"         "syncthingtray"                 "syncthingtray --wait")
  ];
  mappedOverwrites = builtins.listToAttrs (map (obj: {
    name = "applications/${obj.filename}.desktop";
    value.text = ''
      [Desktop Entry]
      Name=${obj.name}
      Type=Application
      Exec=${if obj.exec == true then obj.filename else obj.exec}
      NoDisplay=true
    '';
  }) overwriteLaunchers);
in {
  # Create custom launchers here
  xdg.desktopEntries = mappedCustoms // mappedRemovals;
  xdg.dataFile = {
    # Floorp
    "applications/floorp.desktop".text = ''
      [Desktop Entry]
      Actions=new-private-window;new-window;profile-manager-window
      Categories=Network;WebBrowser
      Exec=floorp --enable-blink-features=MiddleClickAutoscroll
      GenericName=Web Browser
      Icon=ceri-web
      MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;x-scheme-handler/http;x-scheme-handler/https
      Name=Floorp
      StartupNotify=true
      StartupWMClass=floorp
      Terminal=false
      Type=Application
      Version=1.4

      [Desktop Action new-private-window]
      Exec=floorp --private-window --enable-blink-features=MiddleClickAutoscroll
      Name=New Private Window

      [Desktop Action new-window]
      Exec=floorp --new-window --enable-blink-features=MiddleClickAutoscroll
      Name=New Window
    '';
    # Discord
    "applications/discord.desktop".text = ''
      [Desktop Entry]
      Name=Discord
      Type=Application
      Exec=discord --enable-blink-features=MiddleClickAutoscroll --disable-smooth-scrolling
      Icon=ceri-cord
    '';
  } // mappedOverwrites;
}

