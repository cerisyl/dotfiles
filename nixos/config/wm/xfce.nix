{ config, pkgs, lib, ... }: {
  environment.xfce = {
    excludePackages = [ pkgs.xfce.xfce4-terminal ];
  };
}