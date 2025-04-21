# This file dynamically imports configurations.
# You should never need to touch this file.

let
  # Path to ./packages
  baseDir = ./.;

  # Get all subdirectory names
  subdirs = builtins.attrNames (builtins.readDir baseDir);

  # Filter to directories only
  subPkgs = builtins.filter (name:
    (builtins.readDir baseDir).${name} == "directory"
  ) subdirs;

  # Import each default.nix file from the subdirectories
  packageLists = map (name:
    import (baseDir + "/${name}")
  ) subPkgs;

in
  builtins.concatLists packageLists