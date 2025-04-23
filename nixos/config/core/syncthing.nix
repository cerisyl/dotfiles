{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  services.syncthing = {
    enable      = true;
    tray.enable = true;
  };
}
