{ helpers, lib, config, ... }:
{
  plugins.trouble = {
    enable = true;
  };
  keymaps = lib.mkIf config.plugins.trouble.enable [
    {
      key = "<leader>dt";
      action = helpers.mkRaw "require('trouble').toggle";
      options.desc = "open workspace diagnostics";
    }
    {
      key = "]d";
      action = helpers.mkRaw "function() require('trouble').next({skip_groups = true, jump = true}); end";
      options.desc = "next workspace diagnostic";
    }
    {
      key = "[d";
      action = helpers.mkRaw "function() require('trouble').previous({skip_groups = true, jump = true}); end";
      options.desc = "previous workspace diagnostic";
    }
  ];
}
