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
  hasFontDir = builtins.elem "font" subdirs;

  # Import regular packages
  systemPackages = builtins.concatLists (
    map (name:
      import (packageDir + "/${name}/default.nix") { inherit pkgs pkgsUnstable; }
    ) regularDirs
  );

  # Import font packages
  fontPackages = if hasFontDir then
    [ import (packageDir + "/font/default.nix") { inherit pkgs pkgsUnstable; } ]
  else [];

in {
  system  = systemPackages;
  font    = fontPackages;
}