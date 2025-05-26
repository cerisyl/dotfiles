# Automatically reads in anything in extra/autostart
{ config, pkgMap, theme, getThemeFile, myHostname, lib, ... }: let
  baseDir = ../../../extra/autostart;
  
  # Launcher exclusions
  exclude = {
    work    = [ "floorp-work" "slack" "teams" ];
    lesser  = [ "steam" "telegram" ];
  };
  hostExclusions = {
    lux     = [ "battery" ] ++ exclude.work;
    nova    = exclude.work ++ exclude.lesser;
    engrit  = [ "discord" "thunderbird" ] ++ exclude.lesser;
    astore  = [ "battery" "discord" "thunderbird" ] ++ exclude.work ++ exclude.lesser;
    vm      = [ "battery" ] ++ exclude.work ++ exclude.lesser;
  };

  filenames = builtins.filter (name:
    let
      filename    = builtins.baseNameOf (lib.removeSuffix ".desktop" name);
      isExcluded  = builtins.elem filename hostExclusions."${myHostname}";
    in
      isExcluded == false && lib.hasSuffix ".desktop" name
  ) (builtins.attrNames (builtins.readDir baseDir));

  autostartFiles = builtins.listToAttrs (map (name: {
    name = "autostart/${name}";
    value = {
      text = builtins.readFile (baseDir + "/${name}");
    };
  }) filenames);
in {
  xdg.configFile = autostartFiles;
}