# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, ... }: let
  myHostname = "astore";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable myHostname;
}