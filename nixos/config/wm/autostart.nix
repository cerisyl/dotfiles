# Automatically reads in anything in extra/autostart
{ config, lib, ... }: let
  baseDir = ../../../extra/autostart;

  filenames = builtins.filter (name:
    name != "." && name != ".." && lib.hasSuffix ".desktop" name
  ) (builtins.attrNames (builtins.readDir baseDir));

  autostartFiles = builtins.listToAttrs (builtins.map (name: {
    name = "autostart/${name}";
    value = {
      text = builtins.readFile (baseDir + "/${name}");
    };
  }) filenames);
in {
  xdg.configFile = autostartFiles;
}