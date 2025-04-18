{ config, pkgs, lib, extraDir, themeDir, ... }: {
  programs.oh-my-posh = {
    enable    = true;
    settings  = builtins.fromJSON (
      builtins.unsafeDiscardStringContext (builtins.readFile "${themeDir}/omp.theme")
    );
  };
}
