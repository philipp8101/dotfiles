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
      desktop = nixpkgs.lib.nixosSystem { 
        specialArgs = { inherit inputs self; };
        inherit system;
        modules = [ 
          ./configuration
          ./configuration/hyprland.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true; 
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs system user self ; };
              users.${user}.imports = [
                ./home
                ./home/alacritty.nix
                ./home/fonts.nix
                ./home/git.nix
                ./home/hyprland.nix
                ./home/kitty.nix
                ./home/mpv.nix
                ./home/rofi.nix
                ./home/theme.nix
                ./home/tmux.nix
                ./home/waybar.nix
                ./home/xkblayout.nix
                ./home/yazi.nix
                ./home/zoxide.nix
                ./home/zsh.nix
              ];
            };
          }
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
        extraSpecialArgs = { inherit inputs system user self ; };
        modules = [
          ./home
          ./home/alacritty.nix
          ./home/fonts.nix
          ./home/git.nix
          ./home/kitty.nix
          ./home/mpv.nix
          ./home/tmux.nix
          ./home/xkblayout.nix
          ./home/yazi.nix
          ./home/zoxide.nix
          ./home/zsh.nix
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
    tmux = pkgs.writeShellScriptBin "tmux" '' ${pkgs.tmux}/bin/tmux -f ${self.outputs.packages.${system}.homeConfigurations.${user}.activationPackage}/home-files/.config/tmux/tmux.conf '';
    zsh = pkgs.writeShellScriptBin "zsh" '' ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh ${pkgs.zsh}/bin/zsh -d -f -c "source ${self.outputs.packages.${system}.homeConfigurations.${user}.activationPackage}/home-files/.zshrc && ${pkgs.zsh}/bin/zsh" '';
  };});

}
