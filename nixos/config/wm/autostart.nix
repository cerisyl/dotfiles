# Automatically reads in anything in extra/autostart
{ config, pkgs, lib, ... }: let
  baseDir = ../../../extra/autostart;
  allFiles = builtins.attrNames (builtins.readDir baseDir);
  allPaths = builtins.map (name: "${baseDir}/${name}") allFiles;

  validFiles = builtins.filter (file:
    let
      name = baseNameOf file;
    in
      name != "." && name != ".." && lib.hasSuffix ".desktop" name
  ) allPaths;

  autostartFiles = builtins.listToAttrs (builtins.map (file:
    let
      name = baseNameOf file;
    in {
      name = "autostart/${name}";
      value = {
        text = builtins.readFile file;
      };
    }
  ) validFiles);
in {
  xdg.configFile = autostartFiles;
}