{ config, pkgs, lib, extraDir, themeDir, ... }: {
  xdg.autostart.entries = [
    "${extraDir}/autostart/greenclip.desktop"
    "${extraDir}/autostart/keepassxc.desktop"
  ];
}