{config, pkgs, lib, ...}: let {
  nixpkgs.config.pulseaudio = true;
  var = builtins.trace "XFCE I EXIST"

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";
} in {
  var;
}