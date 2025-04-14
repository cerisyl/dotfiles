# This file dynamically imports configurations,
# You should never need to touch this file,
# except for changing the excludedFiles list.

let
  # Exlude specific .nix configurations
  excludedFiles = [
    #"path/to/file.nix"
  ];

  baseDir = ./.;

  # Get all subdirectories
  subdirs = builtins.filter (name:
    (builtins.readDir baseDir).${name} == "directory"
  ) (builtins.attrNames (builtins.readDir baseDir));

  # Get all .nix files in a given dir (excluding default.nix)
  getModulesInDir = dir:
    let
      files = builtins.attrNames (builtins.readDir (baseDir + "/${dir}"));
    in builtins.concatLists (map (file:
      let
        fullPath = "${dir}/${file}";
      in if builtins.match ".*\\.nix" file != null
        && file != "default.nix"
        && !(builtins.elem fullPath excludedFiles)
        then [ "${baseDir}/${fullPath}" ]
        else []
    ) files);

  # Flatten list of lists of modules
  modules = builtins.concatLists (map getModulesInDir subdirs);
in
  modules