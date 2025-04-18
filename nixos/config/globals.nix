{ config, lib, ... }:

let
  themeFile = "${config.home.homeDirectory}/.nix/extra/theme";
  theme = if lib.pathExists themeFile
          then lib.fileContents themeFile
          else "ceres";
  extraDir = "${config.home.homeDirectory}/.nix/extra";
  themeDir = "${config.home.homeDirectory}/.nix/themes/${theme}";
in {
  config._module.args = {
    inherit theme themeDir extraDir;
  };
}