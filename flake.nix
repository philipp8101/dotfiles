{
  description = "NixOS config with home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
  };

  outputs = { self, nixpkgs, home-manager, nixos-generators, nixvim, ... }@inputs: 
  inputs.flake-utils.lib.eachDefaultSystem (system:
  let 
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    user = "philipp";
  in { packages = {
    nixosConfigurations = {
      MAIN = nixpkgs.lib.nixosSystem { 
        specialArgs = { inherit inputs self; };
        inherit system;
        modules = [ 
          ./configuration.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true; 
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs system user ; };
              users.${user}.imports = [
                ./dev.nix
                ./wm.nix
              ];
            };
          }
        ];
      };
      RPI = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs user; };
        modules = [
          ./rpi.nix
	  ./rpi-hardware.nix
	  ./hifiberry.nix
        ];
      };
    };  
    homeConfigurations = {
      dev = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs user ; };
        modules = [
          ./dev.nix
        ];
      };
      full = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs system user ;
        };
        modules = [
          ./dev.nix
          ./wm.nix
        ];
      };
    };
    sdcard = nixos-generators.nixosGenerate {
      system = "aarch64-linux";
      format = "sd-aarch64";
      modules = [
        ./rpi.nix
      ];
    };
    nixvim = (import ./nixvim/nixvim.nix {
      pkgs = (import inputs.nixpkgs-unstable { inherit system; });
      inherit system;
      inherit nixvim;
    });
  };});

}
