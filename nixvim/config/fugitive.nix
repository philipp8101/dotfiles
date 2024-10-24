{
  plugins.fugitive = {
    enable = true;
  };
  keymaps = [
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
