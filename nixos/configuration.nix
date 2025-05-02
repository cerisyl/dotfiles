{ inputs, myHostname, config, pkgs, pkgsUnstable, pkgsGit, ... }: let
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
  # Use binary to determine what packages we should download
  hostIndexMap = {
    "luxe"    = 2;
    "nova"    = 1;
    "astore"  = 0;
    "vm"      = 1;
  };
  hostIndex = hostIndexMap.${myHostname};

  allPackages = import ./packages;

  # Only import packages with an init flag in the
  # specified hostIndexMap position marked "1"
  enabledPackages = builtins.filter (entry:
    let flagString = entry.init;
    in builtins.stringLength flagString > hostIndex &&
      builtins.substring hostIndex 1 flagString == "1"
  ) allPackages;

  # TODO: Would be cool if we can combine these two blocks into
  # a single call- research later.

  # Get our packages using the specified channel of choice (isUnstable)
  systemPackages = map (entry:
    if entry.isUnstable == true
    then getAttrByStr pkgsUnstable entry.pkg
    else getAttrByStr pkgs entry.pkg
  ) enabledPackages;

  # Also spawn an object to use in loading proper packages in config
  pkgMap = builtins.listToAttrs (map (entry:
    if entry.isUnstable == true
    then { name = entry.pkg; value = getAttrByStr pkgsUnstable entry.pkg; }
    else { name = entry.pkg; value = getAttrByStr pkgs entry.pkg; }
  ) enabledPackages);
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
    extraGroups   = [ "wheel" "input" "networkmanager" "deluge" ];
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
      inherit pkgMap theme getThemeFile;
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
  environment.systemPackages  = systemPackages;

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