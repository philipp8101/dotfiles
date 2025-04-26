{ helpers, ... }:
{
  plugins.mini = {
    enable = true;
    modules = {
      files = {};
    };
  };
  keymaps = [
    {
      key = "<leader>X";
      action = helpers.mkRaw "require'mini.files'.open";
      options.desc = "Open Mini.Files";
    }
  ];
}
