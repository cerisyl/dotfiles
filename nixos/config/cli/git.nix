{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.git = {
    enable      = true;
    package     = pkgMap.git;
    userName    = "Spencer Gunning";
    userEmail   = "csit@cering.dev";
    lfs.enable  = true;
  };
}