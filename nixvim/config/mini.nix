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
      action = helpers.mkRaw "require'mini.files'.open";
      options.desc = "Open Mini.Files";
    }
  ];
}
