{
  description = "NixOS config with home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    systems.url = "github:nix-systems/default";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
    hyprpaper-custom.url = "github:philipp8101/hyprpaper";
  };

  outputs = { self, nixpkgs, home-manager, nixos-generators, nixvim, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        user = "philipp";
      in
      {
        packages = {
          nixosConfigurations = {
            desktop = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs self user; };
              inherit system;
              modules = [
                ./configuration
                ./hardware-configuration.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit inputs system user self; };
                    users.${user} = {
                      imports = [
                        ./home
                      ];
                      wayland.windowManager.hyprland = {
                        enable = true;
                        layout = "scroller";
                      };
                    };
                  };
                }
                { programs.hyprland.enable = true; }
              ];
            };
            raspberrypi = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = { inherit inputs user; };
              modules = [
                ./rpi.nix
                ./rpi-hardware.nix
                ./hifiberry.nix
              ];
            };
          };
          homeConfigurations = {
            ${user} = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs system user self; };
              modules = [
                ./home
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
            pkgs = (import inputs.nixpkgs { inherit system; });
            inherit system nixvim self user;
          });
          tmux = pkgs.writeShellScriptBin "tmux" '' ${pkgs.tmux}/bin/tmux -f ${self.packages.${system}.homeConfigurations.${user}}/home-files/.config/tmux/tmux.conf '';
          zsh = pkgs.writeShellScriptBin "zsh" ''
            export PATH=$PATH:${pkgs.fzf}/bin ;
            export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh ;
            export ZDOTDIR=${self.packages.${system}.homeConfigurations.${user}}/home-files ;
            ${pkgs.zsh}/bin/zsh
          '';
          devShell = pkgs.writeShellScriptBin "dev" ''
            alias tmux=${self.packages.${system}.tmux}/bin/tmux ;
            alias vim=${self.packages.${system}.nixvim}/bin/nvim ;
            ${self.packages.${system}.zsh}/bin/zsh
          '';
        };
      });

}
