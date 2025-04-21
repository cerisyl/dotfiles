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

  allPackages = (import ./packages) { inherit pkgs pkgsUnstable; };

  enabledPackages = entries: builtins.filter (entry:
    let flag = entry.init;
    in builtins.stringLength flag > hostIndex &&
      builtins.substring hostIndex 1 flag == "1"
  ) entries;

  systemPackages = map (entry: entry.pkg) (enabledPackages allPackages.system);
  fontPackages   = map (entry: entry.pkg) (enabledPackages allPackages.font);

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
    imports = import ./config/default.nix { role = "home"; };
    home.stateVersion = "24.11";
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
  fonts.packages              = fontPackages;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # NEVER EVER CHANGE THIS.
  system.stateVersion = "24.11";
}