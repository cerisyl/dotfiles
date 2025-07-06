# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, pkgsGit, lib, ... }: let
  myHostname = "lux";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable pkgsGit lib myHostname;
}