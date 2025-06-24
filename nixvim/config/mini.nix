{ helpers, lib, config, ... }:
{
  plugins.mini = {
    enable = true;
    modules = {
      files = {};
    };
  };
  keymaps = lib.mkIf config.plugins.mini.enable [
    {
      key = "<leader>X";
      action = helpers.mkRaw "function() require'mini.files'.open(vim.api.nvim_buf_get_name(0)) end";
      options.desc = "Open Mini.Files";
    }
  ];
}
