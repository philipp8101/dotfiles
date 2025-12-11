{ lib, config, ... }:
{
  plugins.neo-tree = {
    enable = true;
    settings = {
      enable_git_status = true;
      enable_modified_markers = true;
      extraOptions = {
        window = {
          mappings = {
            "n" = "close_node";
            "e" = "none";
            "o" = "none";
            "i" = "open";
            "<leader>as" = "git_add_file";
            "<leader>au" = "git_unstage_file";
            "og" = "noop";
            "ot" = "noop";
            "os" = "noop";
            "om" = "noop";
            "on" = "noop";
            "od" = "noop";
            "oc" = "noop";
          };
        };
        event_handlers = [
          {
            event = "file_opened";
            handler = lib.nixvim.mkRaw "require('neo-tree').close_all";
          }
        ];
      };
    };
  };
  keymaps = lib.mkIf config.plugins.neo-tree.enable [
    {
      key = "<leader>x";
      action = "<cmd>Neotree reveal<CR>";
      options.desc = "Open Filetree";
    }
  ];
  files = {
    "ftplugin/neo-tree.vim" = {
      extraConfigVim = ''
        nmap <buffer> e j
        nmap <buffer> o k
      '';
    };
  };
}
