{
  description = "NixOS config with home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      MAIN = lib.nixosSystem { 
        specialArgs = { inherit inputs; };
        inherit system;
        modules = [ 
          ./configuration.nix
          ./hardware-configuration.nix
          # home-manager.nixosModules.home-manager {
          #   home-manager.useGlobalPkgs = true; 
          #   home-manager.useUserPackages = true;
          #   home-manager.users.philipp = {
          #     imports = [ ./home.nix ];
          #   };
          # }
        ];
      };
    };  
    homeConfigurations = {
      dev = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; user = "nix"; };
        modules = [
          ./dev.nix
        ];
      };
      full = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; user = "nix"; };
        modules = [
          ./dev.nix
          ./wm.nix
        ];
      };
    };
  };

}

