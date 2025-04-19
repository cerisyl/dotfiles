# This file dynamically imports configurations.
# You should never need to touch this file.

{ pkgs, pkgsUnstable }: let
  # Path to ./packages
  packageDir = ./.;

  # Read subdirectories
  allEntries = builtins.readDir packageDir;
  subdirs = builtins.attrNames allEntries;

  isDir = name: allEntries.${name} == "directory";

  # Separate out fontDir from the rest
  regularDirs = builtins.filter (name: isDir name && name != "font") subdirs;
  fontDir = builtins.elem "font" subdirs;

  # Import regular packages
  systemPackages = builtins.concatLists (
    map (name: import (packageDir + "/${name}") pkgs) regularDirs
  );

  # Import font packages
  fontPackages = if fontDir then
    builtins.concatLists (
      [ (import (packageDir + "/font") pkgs) ]
    )
  else
    [];

in {
  system  = systemPackages;
  font    = fontPackages;
}