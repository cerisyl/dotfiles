# This file dynamically imports configurations,
# You should never need to touch this file,
# except for changing the excludedFiles list.

{ role }: let
  # Exlude specific .nix configurations
  excludedFiles = [
    #"file.nix"
    "autostart.nix"
  ];

  baseDir = ./.;

  isNixFile = name: builtins.match ".*\\.nix$" name != null;

  matchesRole = name:
    if role == "system"
    then builtins.match ".*\\.sys\\.nix$" name != null
    else builtins.match ".*\\.sys\\.nix$" name == null; 
  
  # Get all files
  findConfig = dir:
    let
      entries = builtins.attrNames (builtins.readDir dir);
      paths = builtins.concatMap (name:
        let
          path = dir + "/${name}";
          type = (builtins.readDir dir)."${name}";
        in
          if type == "directory" then findConfig path
          else if isNixFile name
          && matchesRole name
          && name != "default.nix"
          && !(builtins.elem name excludedFiles)
          then [ path ]
          else []
      ) entries;
    in
      paths;
  configPaths = findConfig baseDir;
in
  builtins.map import configPaths

