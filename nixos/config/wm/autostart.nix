{ config, pkgs, lib, ... }: {
  xdg.autostart.entries = [
    "${config.home.homeDirectory}/.nix/nixos/assets/autostart/greenclip.desktop"
    "${config.home.homeDirectory}/.nix/nixos/assets/autostart/keepassxc.desktop"
  ];
}