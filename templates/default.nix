{
  haskell = {
    path = ./haskell;
    welcomeText = ''`nix develop .#init -c cabal init --non-interactive --minimal --main-is=main.hs --source-dir=. --application-dir=. && direnv allow`'';
  };
}
