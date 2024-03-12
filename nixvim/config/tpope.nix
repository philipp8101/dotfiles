{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
      vim-sleuth
      vim-repeat
      vim-speeddating
  ];
}
