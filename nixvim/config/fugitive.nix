{ lib, config, ...}:
{
  plugins.fugitive = {
    enable = false;
  };
  keymaps = lib.mkIf config.plugins.fugitive.enable [
    {
      key = "<leader>t";
      action = ":Gedit: <CR>";
      options.desc = "open Fugitive";
    }
    {
      key = "<leader>T";
      action = ":GlLog <CR>";
      options.desc = "git log";
    }
    {
      key = "<leader>ac";
      action = ":Git commit <CR>";
      options.desc = "git commit";
    }
  ];
}
