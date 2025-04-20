# Automatically reads in anything in extra/autostart
{ config, pkgs, lib, ... }: let
  baseDir = ../../../extra/autostart;
  filenames = builtins.filter (name:
    name != "." && name != ".." && lib.hasSuffix ".desktop" name
  ) (builtins.attrNames (builtins.readDir autostartDir));

  autostartFiles = builtins.listToAttrs (builtins.map (name: {
    name = "autostart/${name}";
    value = {
      text = builtins.readFile (autostartDir + "/${name}");
    };
  }) filenames);
in {
  xdg.configFile = autostartFiles;
}