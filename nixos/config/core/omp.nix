{ config, pkgs, lib, ... }: {
  programs.oh-my-posh = {
    enable    = true;
    settings  = builtins.fromJSON (
      builtins.unsafeDiscardStringContext (builtins.readFile "${config.home.homeDirectory}/.nix/themes/ceres/omp.theme")
    );
  };
}
