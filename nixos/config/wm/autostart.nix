{ config, pkgs, lib, ... }: {
  xdg.autostart = {
    enable = true;
    entries = [
      "../../../extra/autostart/greenclip.desktop"
      "../../../extra/autostart/keepassxc.desktop"
    ];
  };
}