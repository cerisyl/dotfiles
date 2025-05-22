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

  # Shortcut conditionals
  onlyLux   = myHostname == "lux";
  notAstore = myHostname != "astore";

  # GPU command stuff
  gpuShPath = "${homedir}/.nix/extra/zshfx/gpu";
  gpuCmd = cmd: (if onlyLux
    then "sh ${gpuShPath} use ${cmd}"
    else cmd);

  custom = condition: name: filename: exec: icon: { inherit condition name filename exec icon; };
  customLaunchers = [
    #custom Condition Name,                     .desktop file,                    Exec (true if == .desktop file),    Icon (true if == .desktop file)
    (custom true      "Lock"                    "lock"                            "xflock4"                           "ceri-lock")
    (custom true      "Restart"                 "restart"                         "reboot"                            "ceri-reboot")
    (custom true      "Shutdown"                "shutdown"                        "shutdown now"                      "ceri-shutdown")
    (custom notAstore "Discord Chat Exporter"   "discordchatexporter"             true                                "ceri-cord")
    (custom true      "Deluge"                  "deluge"                          true                                "ceri-deluge")
    (custom notAstore "ITGmania"                "itgmania"                        (gpuCmd "itgmania")                 "ceri-itg")
    (custom notAstore "Minecraft"               "org.prismlauncher.PrismLauncher" (gpuCmd "prismlauncher")            "ceri-mc")
    (custom notAstore "OBS Studio"              "com.obsproject.Studio"           "obs"                               "ceri-obs")
    (custom notAstore "Kdenlive"                "org.kde.kdenlive"                (gpuCmd "kdenlive")                 "ceri-kden")
    (custom notAstore "Steam"                   "steam"                           true                                "ceri-steam")
    (custom true      "VLC Media Player"        "vlc"                             true                                "ceri-media")
    (custom notAstore "Tauon"                   "tauonmb"                         "tauon"                             "ceri-music")
    (custom true      "Virtual Machine Manager" "virt-manager"                    true                                "ceri-vm")
    (custom true      "KeePassXC"               "org.keepassxc.KeePassXC"         "keepassxc"                         "ceri-pass")
    (custom true      "File Manager"            "xfce4-file-manager"              "exo-open --launch FileManager %u"  "ceri-files")
    (custom notAstore "Email"                   "thunderbird"                     true                                "ceri-email")
    (custom onlyLux   "Blender"                 "blender"                         (gpuCmd "blender %f")               true)
    (custom onlyLux   "Looking Glass Client"    "looking-glass-client"            "looking-glass-client -s -m 97"     "looking-glass")
    (custom notAstore "Dolphin Emulator"        "dolphin-emu"                     (gpuCmd "env QT_QPA_PLATFORM=xcb dolphin-emu")                                                              true)
    (custom notAstore "Discord"                 "discord"                         "discord --enable-blink-features=MiddleClickAutoscroll --disable-smooth-scrolling"                          "ceri-cord")
    (custom notAstore "ArrowVortex"             "av"                              "wine ${homedir}/games/ArrowVortex/ArrowVortex.exe"                                                         "${homedir}/games/ArrowVortex/av.ico")
    (custom onlyLux   "Windows 11"              "win11"                           ''"sh ${gpuShPath} vm && virsh --connect qemu:///system start win11 && looking-glass-client -s -m 97 -F"''  "${homedir}/.icons/ceres-icons/apps/scalable/ceri-start.svg")
  ];
  mappedCustoms = builtins.listToAttrs (map (obj:
    if obj.condition then {
    name = obj.filename;
    value = {
      name = obj.name;
      exec = if obj.exec == true then obj.filename else obj.exec;
      icon = if obj.icon == true then obj.filename else obj.icon;
    };
  } else {}) customLaunchers);

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
  } // mappedOverwrites;
}
