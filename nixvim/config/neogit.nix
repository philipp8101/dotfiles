{
  plugins.neogit = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>t";
      action = ":Neogit kind=replace <CR>";
      options.desc = "open Neogit";
    }
    {
      key = "<leader>ac";
      action = ":Neogit commit <CR>";
      options.desc = "git commit";
    }
  ];
}
