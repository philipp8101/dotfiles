{ pkgs, nixvim, system, ... }:
nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  module = import ./config;
  extraSpecialArgs = {
    inherit pkgs;
  };
}

