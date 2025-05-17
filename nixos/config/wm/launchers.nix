{ config, pkgMap, theme, getThemeFile, lib, ... }: let
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
  mappedLaunchers = builtins.listToAttrs (map (name: {
    inherit name;
    exec = name;
    value = {
      inherit name;
      noDisplay = true;
    };
  }) removeLaunchers);

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
  xdg.desktopEntries = {
    "lock" = {
      name = "Lock";
      exec = "xflock4";
      icon = "ceri-lock";
    };
    "restart" = {
      name = "Restart";
      exec = "reboot";
      icon = "ceri-reboot";
    };
    "shutdown" = {
      name = "Shutdown";
      exec = "shutdown now";
      icon = "ceri-shutdown";
    };
    "discordchatexporter" = {
      name = "Discord Chat Exporter";
      exec = "discordchatexporter";
      icon = "ceri-cord";
    };
    "deluge" = {
      name = "Deluge";
      exec = "deluge";
      icon = "ceri-deluge";
    };
    "itgmania" = {
      name = "ITGmania";
      exec = "itgmania";
      icon = "ceri-itg";
    };
    "org.prismlauncher.PrismLauncher" = {
      name = "Minecraft";
      exec = "prismlauncher";
      icon = "ceri-mc";
    };
    "com.obsproject.Studio" = {
      name = "OBS Studio";
      exec = "obs";
      icon = "ceri-obs";
    };
    "org.kde.kdenlive" = {
      name = "Kdenlive";
      exec = "kdenlive";
      icon = "ceri-kden";
    };
    "steam" = {
      name = "Steam";
      exec = "steam";
      icon = "ceri-steam";
    };
    "vlc" = {
      name = "VLC Media Player";
      exec = "vlc";
      icon = "ceri-media";
    };
    "tauonmb" = {
      name = "Tauon";
      exec = "tauon";
      icon = "ceri-music";
    };
    "virt-manager" = {
      name = "Virtual Machine Manager";
      exec = "virt-manager";
      icon = "ceri-vm";
    };
    "org.keepassxc.KeePassXC" = {
      name = "KeePassXC";
      exec = "keepassxc";
      icon = "ceri-pass";
    };
    "xfce4-file-manager" = {
      name = "File Manager";
      exec = "exo-open --launch FileManager %u";
      icon = "ceri-files";
    };
    "thunderbird" = {
      name = "Email";
      exec = "thunderbird";
      icon = "ceri-email";
    };
  } // mappedLaunchers;
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

