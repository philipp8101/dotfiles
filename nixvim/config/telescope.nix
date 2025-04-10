{
  plugins.telescope = {
    enable = true;
    extensions.ui-select.enable = true;
    keymaps = {
      "<leader>sf" = {
        action = "find_files";
        options.desc = "find files";
      };
      "<leader>sg" = {
        action = "live_grep";
        options.desc = "grep";
      };
      "<leader>st" = {
        action = "git_files";
        options.desc = "git files";
      };
      "<leader>sb" = {
        action = "git_branches";
        options.desc = "git branches";
      };
      "<leader>sc" = {
        action = "git_commits";
        options.desc = "git commits";
      };
      "<leader>sh" = {
        action = "help_tags";
        options.desc = "help tags";
      };
      "<leader>so" = {
        action = "buffers";
        options.desc = "buffers";
      };
    };
  };
}
