{ pkgs, ... }:
# let
# patched-nightfox = pkgs.vimPlugins.nightfox-nvim.overrideAttrs { patches =  [ ./bg-none.patch ]; };
# in
{
  extraPlugins = with pkgs.vimPlugins; [ nightfox-nvim ];
  extraConfigLua = ''
    require("nightfox").setup({
      all = {
        Normal = { bg = "none" }
      }
    })
  ''; # does this work ?
}
