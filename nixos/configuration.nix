{ inputs, myHostname, config, pkgs, pkgsUnstable, ... }: let
  # Package management
  # Use binary to determine what packages we should download
  hostIndexMap = {
    "luxe"    = 2;
    "nova"    = 1;
    "astore"  = 0;
    "vm"      = 1;
  };
  hostIndex = hostIndexMap.${myHostname};

  allPackages = import ./packages { inherit pkgs pkgsUnstable; };

  enabledPackages = builtins.filter (entry:
    let flagString = entry.init;
    in builtins.stringLength flagString > hostIndex &&
      builtins.substring hostIndex 1 flagString == "1"
  ) allPackages;

  myPackages = map (entry: entry.pkg) enabledPackages;

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
    extraGroups   = [ "wheel" "input" "networkmanager" ];
  };

  # Import/set home configuration
  home-manager.users.ceri = {
    imports = [
      ./config/globals.nix
    ] ++ import ./config { role = "home"; };
    home.stateVersion = "24.11";
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 30d";
  };

  # Define packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = myPackages;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # NEVER EVER CHANGE THIS.
  system.stateVersion = "24.11";
}