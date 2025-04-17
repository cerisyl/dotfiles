{ config, pkgs, lib, ... }: {
  programs.fastfetch = {
    enable    = true;
    settings  = {
      logo = {
        source      = "${config.home.homeDirectory}/.nix/nixos/assets/img/rida.png";
        type        = "kitty-direct";
        logo-width  = 30;
        logo-height = 14;
      };
      display = {
        separator         = " ";
        key.width         = 12;
        color             = "blue";
        size.binaryPrefix = "jedec";
        freq.ndigits      = 1;
      };
      modules = [
        "title"
        { type = "os"; format = "{name} {version}"; }
        { type = "custom"; format = "────────────────────────────────"; }
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
      ];
    };
  };
}