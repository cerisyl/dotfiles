{ config, pkgs, lib, ... }: {
  programs.fastfetch = {
    enable    = true;
    settings  = {
      logo = {
        source      = "${config.home.homeDirectory}/.nix/nixos/assets/img/rida.png";
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