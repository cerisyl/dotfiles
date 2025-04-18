{ config, pkgs, lib, ... }: {
  themeFile = "${config.home.homeDirectory}/extra/theme";
  theme = if builtins.pathExists themeFile
          then builtins.readFile themeFile
          else "ceres";
  themeDir = "${config.home.homeDirectory}/.nix/themes/${theme}";
  extraDir = "${config.home.homeDirectory}/.nix/extra";
  programs.git = {
    enable = true;
    userName  = "Spencer Gunning";
    userEmail = "csit@cering.dev";
  };
}