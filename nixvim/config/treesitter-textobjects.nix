{
  plugins.treesitter-textobjects = {
    enable = true;
    settings = {
      enable = true;
      keymaps = {
        "af".query = "@function.outer";
        "if".query = "@function.inner";
        "aa".query = "@parameter.outer";
        "ia".query = "@parameter.inner";
        "ac".query = "@class.outer";
        "ic".query = "@class.inner";
      };
    };
  };
}
