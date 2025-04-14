# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, ... }: let
  myHostname = "vm";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable myHostname;
}