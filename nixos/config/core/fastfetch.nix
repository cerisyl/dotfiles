{ config, pkgs, lib, ... }: let
  themeFile = "${config.home.homeDirectory}/extra/theme";
  theme = if builtins.pathExists themeFile
          then builtins.readFile themeFile
          else "ceres";
  themeDir = "${config.home.homeDirectory}/.nix/themes/${theme}";
  extraDir = "${config.home.homeDirectory}/.nix/extra";
in {
  programs.fastfetch = {
    enable    = true;
    settings  = {
      logo = {
        source      = "${themeDir}/img/fetch.png";
        type        = "kitty-direct";
        width       = 32;
        height      = 15;
        padding     = {
          left      = 3;
          top       = 2;
        };
      };
      display = {
        separator         = " ";
        key.width         = 12;
        color             = "blue";
        size.binaryPrefix = "jedec";
        freq.ndigits      = 1;
      };
      modules = [
        "break"
        "title"
        { type = "custom"; format = "────────────────────────────────"; }
        { type = "os"; format = "{name} {version}"; }
        "host"
        "uptime"
        { type = "packages"; format = "{all}"; }
        "shell"
        { type = "display"; key = "Display"; }
        { type = "wm"; format = "{pretty-name}"; }
        { type = "terminal"; format = "{pretty-name}"; }
        "cpu"
        "gpu"
        "memory"
        { type = "disk"; key = "Disk"; }
        "break"
        "colors"
        "break"
      ];
    };
  };
}