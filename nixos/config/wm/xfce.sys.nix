{ config, pkgs, lib, extraDir, themeDir, ... }: {
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