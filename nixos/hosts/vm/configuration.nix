# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, pkgsGit, ... }: let
  myHostname = "vm";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable pkgsGit myHostname;
}