{
  plugins.undotree.enable = true;
  keymaps = [
    {
      key = "<leader>u";
      action = "<cmd>UndotreeToggle <CR><cmd>UndotreeFocus <CR>";
      options.desc = "open undotree";
    }
  ];
}
