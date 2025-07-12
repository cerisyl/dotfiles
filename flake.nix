{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-legacy.url = "github:nixos/nixpkgs/5395fb3ab3f97b9b7abca147249fa2e8ed27b192"; # for qemu_full
    zmod = {
      url = "github:zarzob/Simply-Love-SM5/itgmania-release";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-legacy, zmod, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    defHost = hostname: nixpkgs.lib.nixosSystem {
      specialArgs = {
        myHostname = hostname;
        pkgsUnstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        pkgsLegacy = import nixpkgs-legacy {
          inherit system;
          config.allowUnfree = true;
        };
        pkgsGit = { inherit zmod; };
        inherit inputs system;
      };
      modules = [
        ./nixos/hosts/${hostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules = [ ];
          system.configurationRevision = self.rev or null;
          system.nixos.label =
            if (self.sourceInfo ? lastModifiedDate) && (self.sourceInfo ? shortRev)
            then "${self.sourceInfo.shortRev}"
            else "${self.sourceInfo.lastModifiedDate}-dirty";
        }
      ];
    };
  in {
    nixosConfigurations = {
      lux     = defHost "lux";
      nova    = defHost "nova";
      astore  = defHost "astore";
      medea   = defHost "medea";
      vm      = defHost "vm";
      engrit  = defHost "engrit";
    };
  };
}