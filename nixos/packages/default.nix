# This file dynamically imports configurations.
# You should never need to touch this file.

{ pkgs, pkgsUnstable }: let
  # Path to ./packages
  baseDir = ./.;

  # Read subdirectories
  subdirs = builtins.attrNames (builtins.readDir baseDir);

  # Filter to directories only
  subPkgs = builtins.filter (name:
    (builtins.readDir baseDir).${name} == "directory"
  ) subdirs;

  # Import each `./<subdir>/default.nix` and call it with pkgs
  rollupPackages = map (name:
    let
      modulePath = baseDir + "/${name}/default.nix";
      packages = import modulePath { inherit pkgs pkgsUnstable; };
    in
      if name == "fonts" then
        { type = "fonts"; value = packages; }
      else
        { type = "system"; value = packages; }
  ) subdirs;

  systemPackages = builtins.concatLists (
    map (entry: if entry.type == "system" then entry.value else []) rollupPackages
  );

  fontPackages = builtins.concatLists (
    map (entry: if entry.type == "fonts" then entry.value else []) rollupPackages
  );

in {
  inherit systemPackages fontPackages;
}