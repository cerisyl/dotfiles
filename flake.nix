{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    defHost = hostname: nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgsUnstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system;
      };
      modules = [ ./nixos/hosts/${hostname}/configuration.nix ];
    };
  in {
    nixosConfigurations.vm = {
      luxe    = defHost "luxe";
      nova    = defHost "nova";
      astore  = defHost "astore";
      vm      = defHost "vm";
    };

    homeConfigurations.ceri = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./home-manager/home.nix ];
    };
  };
}