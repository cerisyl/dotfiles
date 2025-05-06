# Templated file, do not touch!
{ inputs, config, pkgs, pkgsUnstable, pkgsGit, ... }: let
  myHostname = "astore";
in
import ../../configuration.nix {
  inherit inputs config pkgs pkgsUnstable pkgsGit myHostname;
}