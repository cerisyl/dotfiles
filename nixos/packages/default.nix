# This file dynamically imports configurations.
# You should never need to touch this file.

{ pkgs, pkgsUnstable }: let
  # Path to ./packages
  packageDir = ./.;

  # Read subdirectories
  subdirs = builtins.attrNames (builtins.readDir packageDir);

  # Filter to directories only
  subPkgs = builtins.filter (name:
    (builtins.readDir packageDir).${name} == "directory"
  ) subdirs;

  # Import each `./<subdir>/default.nix` and call it with pkgs
  packageLists = map (name:
    import (packageDir + "/${name}") { inherit pkgs pkgsUnstable; }
  ) subPkgs;

in
  builtins.concatLists packageLists