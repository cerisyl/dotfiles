# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, pkgsGit, lib, ... }: let
  myHostname = "medea";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable pkgsGit lib myHostname;
}