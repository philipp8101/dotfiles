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
      inputs.systems.follows = "systems";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    hyprpaper-custom = {
      url = "github:philipp8101/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprlux = {
      url = "github:amadejkastelic/Hyprlux";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixos-generators, nixvim, lanzaboote, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        user = "philipp";
        self = inputs.self.packages.${system};
      in
      {
        packages = {
          nixosConfigurations = builtins.mapAttrs (name: modules:
            nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs self user system lanzaboote; };
              inherit system modules;
            }
          ) self.nixosModules;
          nixosModules = (builtins.mapAttrs (name: modules: [ ./configuration ./host/${name} ] ++ modules) {
            desktop = [
                ./configuration/gaming.nix
                { home-manager.users.${user}.imports = [ ./host/desktop/home.nix ]; }
              ] ++ self.nixosHomeModules.hyprland;
            surface = [
                inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
                { home-manager.users.${user}.imports = [ ./host/surface/home.nix ]; }
              ] ++ self.nixosHomeModules.hyprland;
          })//{
            raspberrypi = [
                {
                  # nixpkgs.buildPlatform = "x86_64-linux";
                #   nixpkgs.hostPlatform = "aarch64-linux";
                }
                inputs.nixos-hardware.nixosModules.raspberry-pi-4
                ./host/raspberrypi
              ];
          };
          nixosHomeModules = builtins.mapAttrs (_: imports: [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs system user self; };
                users.${user} = {
                  inherit imports;
                };
              };
            }
          ]) self.homeModules;
          homeConfigurations = builtins.mapAttrs (_: modules: home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs system user self; };
            inherit modules;
          }) self.homeModules;
          homeModules = builtins.mapAttrs (_: module: [ ./home module ] ) {
            hyprland = {
              wayland.windowManager.hyprland.enable = true;
            };
            i3 = {
              xsession.windowManager.i3.enable = true;
            };
            minimal = { gui = false; };
          };
          sdcard = nixos-generators.nixosGenerate {
            system = "aarch64-linux";
            format = "sd-aarch64";
            specialArgs = { inherit inputs self user system; };
            modules = self.nixosModules.raspberrypi;
          };
          nixvim = (import ./nixvim/nixvim.nix {
            inherit system nixvim self user inputs pkgs;
          });
          tmux = pkgs.writeShellScriptBin "tmux" '' ${pkgs.tmux}/bin/tmux -f ${self.homeConfigurations.minimal.activationPackage}/home-files/.config/tmux/tmux.conf '';
          zsh = pkgs.writeShellScriptBin "zsh" ''
            export PATH=$PATH:${pkgs.fzf}/bin ;
            export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh ;
            export ZDOTDIR=${self.homeConfigurations.minimal.activationPackage}/home-files ;
            ${pkgs.zsh}/bin/zsh
          '';
          devShell = pkgs.writeShellScriptBin "dev" ''
            alias tmux=${self.tmux}/bin/tmux ;
            alias vim=${self.nixvim}/bin/nvim ;
            ${self.zsh}/bin/zsh
          '';
        };
      })//{
        templates = import ./templates;
      };

}
