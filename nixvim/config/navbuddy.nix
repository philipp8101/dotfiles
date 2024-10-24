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
  keymaps = [
    {
      key = "<leader>h";
      action.__raw = ''require("nvim-navbuddy").open'';
    }
  ];
}
