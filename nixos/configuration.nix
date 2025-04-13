{ inputs, config, pkgs, pkgsUnstable, ... }: let
  # Define hostname
  myHostname = "luxe";

  # Package management
  # Use binary to determine what packages we should download
  hostIndexMap = {
    "luxe"    = 2;
    "nova"    = 1;
    "astore"  = 0;
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
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable                 = true;
  boot.loader.grub.devices                = [ "nodev" ];
  boot.loader.grub.efiSupport             = true;
  boot.loader.grub.useOSProber            = true;
  boot.loader.efi.canTouchEfiVariables    = true;

  # Main params
  networking.hostName = myHostname;
  time.timeZone       = "America/Chicago";
  i18n.defaultLocale  = "en_US.UTF-8";

  # Networking
  networking.networkmanager.enable = true;

  # Users
  users.users.ceri = {
    isNormalUser  = true;
    extraGroups   = [ "wheel" "input" "networkmanager" ];
  };

  # Define packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = myPackages;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # NEVER EVER CHANGE THIS.
  system.stateVersion = "24.11";
}