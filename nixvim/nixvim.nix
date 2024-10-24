{ pkgs, nixvim, system, ... }@inputs:
nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  module = import ./config;
  extraSpecialArgs = inputs;
}

