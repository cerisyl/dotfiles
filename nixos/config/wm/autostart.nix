{ config, pkgs, lib, ... }: {
  xdg.autostart.entries = [
    "${config.home.homeDirectory}/.nix/extra/autostart/greenclip.desktop"
    "${config.home.homeDirectory}/.nix/extra/autostart/keepassxc.desktop"
  ];
}