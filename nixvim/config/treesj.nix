{ lib, config, ... }:
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
      action = lib.nixvim.mkRaw "require('treesj').split";
      options.desc = "split code block";
    }
    {
      key = "gj";
      action = lib.nixvim.mkRaw "require('treesj').join";
      options.desc = "join code block";
    }
  ];
}
