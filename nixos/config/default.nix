# This file dynamically imports configurations,
# You should never need to touch this file,
# except for changing the excludedFiles list.

{ role }: let
  # Exlude specific .nix configurations
  excludedFiles = [
    #"file.nix"
  ];

  baseDir = ./.;

  isNixFile = name: builtins.match ".*\\.nix$" name != null;

  matchesRole = name:
    if role == "system"
    then builtins.match ".*\\.sys\\.nix$" name != null
    else builtins.match ".*\\.sys\\.nix$" name == null; 
  
  # Get all files
  findConfig = dir:
    builtins.concatLists (map (name:
      let
        path = baseDir + "/${name}";
        type = (builtins.readDir dir)."${name}";
      in
        builtins.trace "Scanning ${toString path} for ${role}" (
          if type == "directory" then (findConfig name)
          else if isNixFile name
          && matchesRole name
          && name != "default.nix"
          && !(builtins.elem name excludedFiles)
          then builtins.trace "Found!! ${toString path}" [ (import path) ]
          else builtins.trace "Skipped ${toString path}" []
        )
    ) (builtins.attrNames (builtins.readDir dir))
  );
in
  findConfig baseDir