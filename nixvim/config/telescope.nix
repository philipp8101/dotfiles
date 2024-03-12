{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>sf" = {
          action = "find_files";
          desc = "find files";
      };
      "<leader>sg" = {
          action = "live_grep";
          desc = "grep";
      };
      "<leader>st" = {
          action = "git_files";
          desc = "git files";
      };
      "<leader>sb" = {
          action = "git_branches";
          desc = "git branches";
      };
      "<leader>sc" = {
          action = "git_commits";
          desc = "git commits";
      };
      "<leader>sh" = {
          action = "help_tags";
          desc = "help tags";
      };
      "<leader>so" = {
          action = "buffers";
          desc = "buffers";
      };
    };
  };
}
