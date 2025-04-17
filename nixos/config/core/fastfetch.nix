{ config, pkgs, lib, ... }: {
  programs.fastfetch = {
    enable    = true;
    settings  = {
      logo = {
        source = "nixos";
        padding = {
          right = 1;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
        separator = "\t";
      };
      modules = [
        { type = "os"; format = "{name} {version}"; }
        "host"
        "uptime"
        "packages"
        "shell"
        "display"
        "wm"
        "terminal"
        "cpu"
        "gpu"
        "memory"
        "disk"
      ];
    };
  };
}