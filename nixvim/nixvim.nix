{ pkgs, nixvim, system, ... }@inputs:
let
inherit (pkgs) lib;
allNixFiles = path:  lib.fileset.toList (
  lib.fileset.fileFilter (file: file.hasExt "nix") path
);

in
nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  module = {
    imports = builtins.concatMap allNixFiles [
      ./config
      ./modules
    ];
  };
  extraSpecialArgs = inputs;
}

