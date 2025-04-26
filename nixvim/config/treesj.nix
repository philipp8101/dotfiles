{ helpers, lib, config, ... }:
{
  plugins.treesj = {
    enable = true;
    settings = {
      max_join_length = 500;
      use_default_keymaps = false;
    };
  };
  keymaps = lib.mkIf config.plugins.treesj.enable [
    {
      key = "gs";
      action = helpers.mkRaw "require('treesj').split";
      options.desc = "split code block";
    }
    {
      key = "gj";
      action = helpers.mkRaw "require('treesj').join";
      options.desc = "join code block";
    }
  ];
}
