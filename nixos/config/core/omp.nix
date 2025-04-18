{ config, pkgs, lib, ... }: {
  programs.oh-my-posh = {
    enable    = true;
    settings  = builtins.fromJSON ;
  };
}
