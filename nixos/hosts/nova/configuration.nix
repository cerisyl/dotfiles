# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, pkgsLegacy, pkgsGit, lib, ... }: let
  myHostname = "nova";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable pkgsLegacy pkgsGit lib myHostname;
}