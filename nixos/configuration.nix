{ inputs, myHostname, config, pkgs, pkgsUnstable, pkgsGit, lib, ... }: let
  # Utility functions to translate 
  # TODO: Move this in its own file.
  getAttrByList = set: pathList:
    if pathList == [] then set
    else getAttrByList (set.${builtins.head pathList}) (builtins.tail pathList) ;
  getAttrByStr = set: pathStr:
    let
      _path = builtins.split "\\." pathStr;
      path = builtins.filter (x: x != []) _path;
    in
      getAttrByList set path;

  # Variable + utility function to determine what theme file should be loaded
  themeFallback = "ceres";
  theme = if (builtins.pathExists ../.current_theme)
    then let
      themeName = builtins.readFile ../.current_theme;
      themePath = ../themes + "/${themeName}";
    in if (builtins.pathExists themePath)
      then themeName
      else themeFallback
    else themeFallback;
  getThemeFile = file: (
    let path = ../themes + "/${theme}/${file}";
    in
      if (builtins.pathExists path) then path
      else ../themes + "/${themeFallback}/${file}"
  );

  # Package management
  # Determine what packages we should download
  hostMap = {
    "lux"     = "l";
    "nova"    = "n";
    "vm"      = "n";
    "astore"  = "a";
    "medea"   = "m";
    "engrit"  = "e";
  };
  hostID = hostMap.${myHostname};

  # Load and parse our pkgs.csv
  pkgsCsv = builtins.readFile ./pkgs.csv;
  pkgsClean = builtins.filter (entry:
    !(lib.strings.hasInfix "#" entry) && !(entry == "")
  ) (lib.strings.splitString "\n" pkgsCsv);
  pkgsSplit = map (entry:
    lib.strings.splitString "|" entry
  ) pkgsClean;
  allPkgs = map (entry: {
    init        = builtins.elemAt entry 0;
    isUnstable  = lib.strings.hasInfix "*" (builtins.elemAt entry 1);
    pkg         = lib.strings.trim (builtins.elemAt entry 2);
  }) pkgsSplit;

  # Only import packages containing the hostID in the init string
  enabledPkgs = builtins.filter (entry:
    lib.strings.hasInfix hostID entry.init
  ) allPkgs;

  # TODO: Would be cool if we can combine these two blocks into
  # a single call- research later.

  # Get our packages using the specified channel of choice (isUnstable)
  systemPkgs = map (entry:
    if entry.isUnstable == true
    then getAttrByStr pkgsUnstable entry.pkg
    else getAttrByStr pkgs entry.pkg
  ) enabledPkgs;

  # Also spawn an object to use in loading proper packages in config
  pkgMap = builtins.listToAttrs (map (entry:
    if entry.isUnstable == true
    then { name = entry.pkg; value = getAttrByStr pkgsUnstable entry.pkg; }
    else { name = entry.pkg; value = getAttrByStr pkgs entry.pkg; }
  ) enabledPkgs);
in {
  # Main params
  networking.hostName = myHostname;
  time.timeZone       = "America/Chicago";
  i18n.defaultLocale  = "en_US.UTF-8";

  # Networking
  networking.networkmanager.enable = true;

  # Import hardware config
  imports = [
    ./hosts/${myHostname}/hardware-configuration.nix
  ] ++ import ./config { role = "system"; };

  # Users
  programs.zsh.enable = true;
  users.users.ceri = {
    isNormalUser  = true;
    shell         = pkgsUnstable.zsh;
    extraGroups   = [ "wheel" "input" "networkmanager" "deluge" "libvirtd" ];
  };

  # Import/set home configuration
  home-manager = {
    # Users
    users.ceri = {
      home.stateVersion  = "24.11";
      imports = import ./config/default.nix { role = "home"; };
    };
    # Packages, etc.
    extraSpecialArgs = {
      inherit pkgMap theme getThemeFile myHostname;
      homedir  = "/home/ceri";
      timezone = config.time.timeZone;
      zmod = pkgsGit.zmod;
    };
    # Handle backup files
    backupFileExtension = "63a4305d";
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 30d";
  };

  # Define packages
  nixpkgs.config.allowUnfree  = true;
  environment.systemPackages  = systemPkgs;

  # Allow dynamically linked executables
  programs.nix-ld.enable    = true;
  programs.nix-ld.libraries = [];

  # Fonts
  fonts.packages = [
    pkgs.inter
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-color-emoji
    #pkgs.barlow - Gives issues with QT apps
    pkgs.roboto
    pkgsUnstable.nerd-fonts.jetbrains-mono
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NEVER EVER CHANGE THIS.
  system.stateVersion = "24.11";
}