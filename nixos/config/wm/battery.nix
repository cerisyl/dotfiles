{ config, pkgMap, myHostname, lib, ... }: let
  # Make life easier - prefixes a key in an attribute set
  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "${prefix}${name}" value);

  deviceType = if myHostname == "nova" || myHostname == "engrit"
    then "laptop"
    else "desktop";
  extraOptions = {
    laptop = {
      powerButtonAction = 2;
      handleKeys        = true;
      handleDisplay     = true;
      trayIcon          = true;
    };
    desktop = {
      powerButtonAction = 3;
      handleKeys        = false;
      handleDisplay     = false;
      trayIcon          = false;
    };
  };

  #################
  # 0 = do nothing
  # 1 = sleep
  # 2 = hibernate
  # 3 = shutdown
  # 4 = ask
  #################
  powerSettings = prependAttrs "xfce4-power-manager/" {
    # General
    "power-button-action"               = extraOptions."${deviceType}".powerButtonAction;
    "hibernate-button-action"           = 2;
    "sleep-button-action"               = 1;
    "battery-button-action"             = 0;
    "handle-brightness-keys"            = extraOptions."${deviceType}".handleKeys;
    "brightness-step-count"             = 15;
    "brightness-exponential"            = false;
    "general-notification"              = true;
    "show-tray-icon"                    = extraOptions."${deviceType}".trayIcon;
    # On battery
    "inactivity-sleep-mode-on-battery"  = 2;
    "inactivity-on-battery"             = 30;
    "lid-action-on-battery"             = 2;
    "blank-on-battery"                  = 3;
    "dpms-on-battery-sleep"             = 5;
    "dpms-on-battery-off"               = 10;
    "brightness-level-on-battery"       = 20;
    "brightness-on-battery"             = 120;
    # On AC
    "inactivity-sleep-mode-on-ac"       = 1;
    "inactivity-on-ac"                  = 0; # never
    "lid-action-on-ac"                  = 1;
    "blank-on-ac"                       = 0; # never
    "dpms-on-ac-sleep"                  = 0;
    "dpms-on-ac-off"                    = 0;
    "brightness-level-on-ac"            = 20;
    "brightness-on-ac"                  = 0; # never
    # system
    "critical-power-level"              = 10;
    "critical-power-action"             = 0;
    "lock-screen-suspend-hibernate"     = true;
    # display
    "dpms-enabled"                      =  extraOptions."${deviceType}".handleDisplay;
  };
in {
  xfconf.settings.xfce4-power-manager = powerSettings;
}