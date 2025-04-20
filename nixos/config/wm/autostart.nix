# Automatically reads in anything in extra/autostart
{ config, pkgs, lib, ... }: let
  autostartFiles = builtins.listToAttrs (map (file:
    let
      name = baseNameOf file;
    in {
      name = "autostart/${name}";
      value.text = builtins.readFile file;
    }) (builtins.filter
      (f: baseNameOf f != "." && baseNameOf f != "..")
      (builtins.attrNames (builtins.readDir ../../extra/autostart))
      |> map (f: ../../../extra/autostart + "/${f}")
    ));
in {
  xdg.configFile = autostartFiles;
}