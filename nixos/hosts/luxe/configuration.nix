# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, pkgsGit, ... }: let
  myHostname = "luxe";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable pkgsGit myHostname;
}