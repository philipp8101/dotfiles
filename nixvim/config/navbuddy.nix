{ helpers, lib, config, ... }:
{
  plugins.navbuddy = {
    enable = true;
    mappings = {
      "n" = "parent";
      "e" = "next_sibling";
      "o" = "previous_sibling";
      "i" = "children";
    };
    lsp.autoAttach = true;
  };
  keymaps = lib.mkIf config.plugins.navbuddy.enable [
    {
      key = "<leader>h";
      action = helpers.mkRaw "require('nvim-navbuddy').open";
    }
  ];
}
