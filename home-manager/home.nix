{ config, pkgs, ... }: {
  imports = import ./packages/default.nix;
  programs.home-manager.enable = true;

  home = {
    username = "ceri";
    homeDirectory = "/home/ceri";
    stateVersion = "24.11";
  };
}