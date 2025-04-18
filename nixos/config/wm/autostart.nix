{ config, pkgs, lib, ... }: {
  xdg.autostart.entries = [
    "${extraDir}/autostart/greenclip.desktop"
    "${extraDir}/autostart/keepassxc.desktop"
  ];
}