{config, pkgs, lib, ...}: {
  programs.git = {
    enable = true;
    userName  = "Spencer Gunning";
    userEmail = "csit@cering.dev";
  };
}