{
  description = "NixOS config with home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    mach-nix.url = "github:davhau/mach-nix";
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
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true; 
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; inherit system; user = "philipp"; };
              users.philipp.imports = [
                ./dev.nix
                ./wm.nix
              ];
            };
          }
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
        extraSpecialArgs = {
          inherit inputs;
          inherit system;
          user = "philipp";
        };
        modules = [
          ./dev.nix
          ./wm.nix
        ];
      };
    };
    neovim = pkgs.mkShell {
      name = "neovim-shell";
      buildInputs = with pkgs; [ lua-language-server nil stylua luajitPackages.luacheck go cargo nodejs_21 gcc ];
      shellHook = ''
        alias vim="${pkgs.neovim}/bin/nvim -u ${./nvim}/init.lua"
        vim
      '';
    };
  };

}

