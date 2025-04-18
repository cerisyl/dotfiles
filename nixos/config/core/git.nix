{ config, pkgs, lib, extraDir, themeDir, ... }: {
  programs.git = {
    enable = true;
    userName  = "Spencer Gunning";
    userEmail = "csit@cering.dev";
  };
}