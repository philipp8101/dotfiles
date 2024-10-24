{
  plugins.trouble = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>dt";
      action.__raw = ''function() require("trouble").toggle(); end'';
      options.desc = "open workspace diagnostics";
    }
    {
      key = "]d";
      action.__raw = ''function() require("trouble").next({skip_groups = true, jump = true}); end'';
      options.desc = "next workspace diagnostic";
    }
    {
      key = "[d";
      action.__raw = ''function() require("trouble").previous({skip_groups = true, jump = true}); end'';
      options.desc = "previous workspace diagnostic";
    }
  ];
}
