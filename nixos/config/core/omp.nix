{ config, pkgs, lib, ... }: {
  programs.oh-my-posh = {
    enable    = true;
    settings  = builtins.fromJSON (
      builtins.unsafeDiscardStringContext (builtins.readFile ../../../themes/ceres/omp.theme)
    );
  };
}
