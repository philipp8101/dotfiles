{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ treesj ];
  extraConfigLua = ''
    require('treesj').setup({
        max_join_length = 500,
        use_default_keymaps = false;
    })
  '';
  keymaps = [
    {
      key = "gs";
      action = "<cmd>lua require('treesj').split() <CR>";
      options.desc = "split code block";
    }
    {
      key = "gj";
      action = "<cmd>lua require('treesj').join() <CR>";
      options.desc = "join code block";
    }
  ];
}
