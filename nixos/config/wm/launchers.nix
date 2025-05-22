{ config, pkgMap, theme, getThemeFile, myHostname, homedir, lib, ... }: let
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

  # Used when removeLaunchers simply doesn't cut it.
  # These files go into .local/share/applications
  overwrite = name: filename: exec: { inherit name filename exec; };
  overwriteLaunchers = [
    #overwrite Name                     .desktop file                   Exec (true if == .desktop file)
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
    (overwrite "Syncthing Tray"         "syncthingtray"                 "syncthingtray --wait --single-instance")
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

  # Use binary to determine what packages we should download
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

  # GPU command stuff
  gpuShPath = "${homedir}/.nix/extra/zshfx/gpu";
  gpuCmd = cmd: (if myHostname == "lux"
    then "sh ${gpuShPath} use ${cmd}"
    else cmd);

  custom = init: name: filename: exec: icon: { inherit init name filename exec icon; };
  customLaunchers = [
    #custom init      Name                      .desktop file                     Exec (true if == .desktop file)                       Icon (true if == .desktop file)
    # core
    (custom "0111"    "Email"                   "thunderbird"                     true                                                  "ceri-email")
    (custom "1111"    "KeePassXC"               "org.keepassxc.KeePassXC"         "keepassxc"                                           "ceri-pass")
    (custom "1111"    "Lock"                    "lock"                            "xflock4"                                             "ceri-lock")
    (custom "1111"    "Restart"                 "restart"                         "reboot"                                              "ceri-reboot")
    (custom "1111"    "Shutdown"                "shutdown"                        "shutdown now"                                        "ceri-shutdown")
    # create
    (custom "0001"    "Blender"                 "blender"                         (gpuCmd "blender %f")                                 true)
    (custom "0011"    "Kdenlive"                "org.kde.kdenlive"                (gpuCmd "kdenlive")                                   "ceri-kden")
    (custom "0011"    "OBS Studio"              "com.obsproject.Studio"           "obs"                                                 "ceri-obs")
    # ent
    (custom "0011"    "ArrowVortex"             "av"                              "wine ${homedir}/games/ArrowVortex/ArrowVortex.exe"   "${homedir}/games/ArrowVortex/av.ico")
    (custom "1011"    "Deluge"                  "deluge"                          true                                                  "ceri-deluge")
    (custom "0011"    "Dolphin Emulator"        "dolphin-emu"                     (gpuCmd "env QT_QPA_PLATFORM=xcb dolphin-emu")        true)
    (custom "0011"    "ITGmania"                "itgmania"                        (gpuCmd "itgmania")                                   "ceri-itg")
    (custom "0011"    "Minecraft"               "org.prismlauncher.PrismLauncher" (gpuCmd "prismlauncher")                              "ceri-mc")
    (custom "0011"    "Steam"                   "steam"                           true                                                  "ceri-steam")
    (custom "0111"    "Tauon"                   "tauonmb"                         "tauon"                                               "ceri-music")
    (custom "1111"    "VLC Media Player"        "vlc"                             true                                                  "ceri-media")
    # soc
    (custom "0011"    "Discord"                 "discord"                         "discord --enable-blink-features=MiddleClickAutoscroll --disable-smooth-scrolling"      "ceri-cord")
    # util
    (custom "0011"    "Discord Chat Exporter"   "discordchatexporter"             true                                                  "ceri-cord")
    # vm
    (custom "0001"    "Looking Glass Client"    "looking-glass-client"            "looking-glass-client -s -m 97"                       "looking-glass")
    (custom "1111"    "Virtual Machine Manager" "virt-manager"                    true                                                  "ceri-vm")
    # wm
    (custom "1111"    "File Manager"            "xfce4-file-manager"              "exo-open --launch FileManager %u"                    "ceri-files")
  ];

  # Only create custom launchers with init flag in the
  # specified hostIndexMap position marked "1"
  filteredCustoms = builtins.filter (entry:
    let flagString = entry.init;
    in builtins.stringLength flagString > hostIndex &&
      builtins.substring hostIndex 1 flagString == "1"
  ) customLaunchers;

  # TODO: Maybe combine this into one command
  mappedCustoms = builtins.listToAttrs (map (obj: {
    name = "applications/${obj.filename}.desktop";
    value.text = ''
      [Desktop Entry]
      Name=${obj.name}
      Type=Application
      exec=${if obj.exec == true then obj.filename else obj.exec}
      icon=${if obj.icon == true then obj.filename else obj.icon}
    '';
  }) filteredCustoms);

  # Windows 11 command (command varies by host)
  win11Cmd = {
    gpu   = ''sh -c "sh ${gpuShPath} vm; && virsh --connect qemu:///system start win11; && looking-glass-client -s -m 97 -F;"'';
    noGpu = "virt-manager --connect qemu:///system --show-domain-console win11";
  };
  winLauncher = ''
    [Desktop Entry]
    Name=Windows 11
    Type=Application
    Exec=${if myHostname == "lux" then win11Cmd.gpu else win11Cmd.noGpu}
    Icon="${homedir}/.icons/ceres-icons/apps/scalable/ceri-start.svg"
    ${if myHostname == "astore" then "NoDisplay=true" else ""}
  '';

in {
  # Create custom launchers here
  xdg.desktopEntries = mappedRemovals;
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
    "applications/win11.desktop".text = winLauncher;
  } // mappedOverwrites // mappedCustoms;
}
