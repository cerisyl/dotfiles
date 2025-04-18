{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, themeDir, extraDir, ... }@inputs:
  let
    system = "x86_64-linux";
    defHost = hostname: nixpkgs.lib.nixosSystem {
      specialArgs = {
        myHostname = hostname;
        pkgsUnstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system;
      };
      modules = [
        ./nixos/hosts/${hostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
      ];
    };
  in {
    nixosConfigurations = {
      luxe    = defHost "luxe";
      nova    = defHost "nova";
      astore  = defHost "astore";
      vm      = defHost "vm";
    };
  };
}