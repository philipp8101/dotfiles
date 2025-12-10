{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
  system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; };
  in {

    packages.x86_64-linux = {
      default = pkgs.haskellPackages.developPackage {
        root = ./.;
        modifier = drv:
          pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages;
              [ 
              haskell-language-server
              cabal-install
              ]);
      };
      init = pkgs.mkShell {
        packages = with pkgs; [
          ghc
          cabal-install
        ];
      };
    };
  };
}
