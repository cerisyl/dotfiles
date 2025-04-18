{ config, pkgs, lib, ... }: let
  themeFile = "${config.home.homeDirectory}/extra/theme";
  theme = if builtins.pathExists themeFile
          then builtins.readFile themeFile
          else "ceres";
  themeDir = "${config.home.homeDirectory}/.nix/themes/${theme}";
  extraDir = "${config.home.homeDirectory}/.nix/extra";
in {
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  nixpkgs.config.pulseaudio = true;
  services.displayManager.defaultSession = "xfce";
  environment.xfce.excludePackages = [ pkgs.xfce.xfce4-terminal ];
}