{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];
  colorScheme =
    let
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
        sha256 = "sha256-pZNzlcLsyl4M0wSKeg4lhptZAOaw1R+roheZaPMQryY=";
      };
      nightfox = pkgs.fetchFromGitHub {
        owner = "EdenEast";
        repo = "nightfox.nvim";
        rev = "7557f26defd093c4e9bc17f28b08403f706f5a44";
        sha256 = "sha256-fVHC3FfGeRGYtB1MKpmLSITk9TDBY/yDCOlQuKvAH5I=";
      };
      theme = src: theme_name: inputs.nix-colors.lib.schemeFromYAML theme_name (builtins.readFile "${src}/${theme_name}.yaml");
    in
    # theme unikitty "unikitty-reversible";
      # theme tinted-theming "gigavolt";
      # theme tinted-theming "catppuccin-macchiato";
      # theme nightfox "extra/carbonfox/base16";
    inputs.nix-colors.lib.schemeFromYAML "carbonfox" (builtins.readFile "${nightfox}/extra/carbonfox/base16.yaml");
}
