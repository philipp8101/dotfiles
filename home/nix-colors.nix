{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];
  colorScheme = let
  tinted-theming = pkgs.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "base16-schemes";
    rev = "2b6f2d0677216ddda50c9cabd6ee70fae4665f81";
    sha256 = "sha256-VTczZi1C4WSzejpTFbneMonAdarRLtDnFehVxWs6ad0=";
  };
  unikitty = pkgs.fetchFromGitHub {
    owner = "joshwlewis";
    repo = "base16-unikitty";
    rev = "28362f3a37a0e81b04d844aa5b2923ad63140734";
    sha256 = "sha256-VTczZi1C4WSzejpTFbneMonAdarRLtDnFehVxWs6ad0=";
  };
  theme = src: theme_name: inputs.nix-colors.lib.schemeFromYAML theme_name (builtins.readFile "${src}/${theme_name}.yaml");
  in
  # theme unikitty "unikitty-reversible";
  theme tinted-theming "gigavolt";
  # theme "carbonfox";
}
