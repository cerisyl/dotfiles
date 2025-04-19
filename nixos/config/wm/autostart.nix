{ config, pkgs, lib, ... }: {
  xdg.autostart.entries = [
    "../../../extra/autostart/greenclip.desktop"
    "../../../extra/autostart/keepassxc.desktop"
  ];
}