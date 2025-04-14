# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, ... }: let
  myHostname = "luxe";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable myHostname;
}