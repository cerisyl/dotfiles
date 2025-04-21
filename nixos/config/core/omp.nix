{ config, pkgMap, lib, ... }: {
  programs.oh-my-posh = {
    enable    = true;
    package   = pkgMap.oh-my-posh;
    settings  = builtins.fromJSON (builtins.readFile ../../../themes/ceres/omp.json);
  };
}
