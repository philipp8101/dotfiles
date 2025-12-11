{ lib, config, ... }:
{
  plugins.undotree.enable = true;
  keymaps = lib.mkIf config.plugins.undotree.enable [
    {
      key = "<leader>u";
      action = lib.nixvim.mkRaw "function() vim.cmd.UndotreeToggle(); vim.cmd.UndotreeFocus(); end";
      options.desc = "open undotree";
    }
  ];
}
