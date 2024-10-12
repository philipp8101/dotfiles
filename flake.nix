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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-generators, nixvim, ... }@inputs: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    user = "philipp";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      MAIN = lib.nixosSystem { 
        specialArgs = { inherit inputs; };
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
      RPI = lib.nixosSystem {
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
    packages.aarch64-linux = {
      sdcard = nixos-generators.nixosGenerate {
        system = "aarch64-linux";
        format = "sd-aarch64";
        modules = [
          ./rpi.nix
        ];
      };
    };
    dev-env = pkgs.mkShell {
      name = "neovim-shell";
      buildInputs = with pkgs; [
        lua-language-server
        nil
        stylua
        luajitPackages.luacheck
        go
        cargo
        nodejs_21
        gcc
      ];
      shellHook = ''
        alias vim=${self.nixvim}/bin/nvim
      '';
    };
    nixvim = (import ./nixvim/nixvim.nix {
      pkgs = (import nixpkgs { inherit system; });
      inherit system;
      inherit nixvim;
    });
  };

}
