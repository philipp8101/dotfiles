{ lib, config, ... }:
{
  # config.diff_opts.internal = true;
  plugins.gitsigns = {
    enable = true;
    # wordDiff = true;
    settings = {
      signcolumn = true;
    };
  };
  keymaps = lib.mkIf config.plugins.gitsigns.enable [
    {
      mode = [ "n" ];
      key = "<leader>as";
      action = lib.nixvim.mkRaw "require('gitsigns').stage_hunk";
      options.desc = "stage hunk";
    }
    {
      mode = [ "v" ];
      key = "<leader>as";
      action = ''<cmd>Gitsigns stage_hunk <CR>'';
      options.desc = "stage hunk";
    }
    {
      mode = [ "n" "v" ];
      key = "<leader>ar";
      action = lib.nixvim.mkRaw "require('gitsigns').reset_hunk";
      options.desc = "reset hunk";
    }
    {
      mode = [ "n" ];
      key = "<leader>aS";
      action = lib.nixvim.mkRaw "require('gitsigns').stage_buffer";
      options.desc = "stage buffer";
    }
    {
      mode = [ "n" ];
      key = "<leader>au";
      action = lib.nixvim.mkRaw "require('gitsigns').undo_stage_hunk";
      options.desc = "undo stage hunk";
    }
    {
      mode = [ "n" ];
      key = "<leader>aR";
      action = lib.nixvim.mkRaw "require('gitsigns').reset_buffer";
      options.desc = "reset buffer";
    }
    {
      mode = [ "n" ];
      key = "<leader>ap";
      action = lib.nixvim.mkRaw "require('gitsigns').preview_hunk";
      options.desc = "preview hunk";
    }
    {
      mode = [ "n" ];
      key = "<leader>ab";
      action = lib.nixvim.mkRaw "function() require('gitsigns').blame_line({ full = true }) end";
      options.desc = "full blame";
    }
    {
      mode = [ "n" ];
      key = "<leader>al";
      action = lib.nixvim.mkRaw "require('gitsigns').toggle_current_line_blame";
      options.desc = "toggle line blame";
    }
    {
      mode = [ "n" ];
      key = "<leader>ad";
      action = lib.nixvim.mkRaw "require('gitsigns').diffthis";
      options.desc = "diff file";
    }
    {
      mode = [ "n" ];
      key = "<leader>aD";
      action = lib.nixvim.mkRaw "function() require('gitsigns').diffthis('~') end";
      options.desc = "diff file with HEAD~";
    }
    {
      mode = [ "n" ];
      key = "<leader>ax";
      action = lib.nixvim.mkRaw "require('gitsigns').toggle_deleted";
      options.desc = "toggle deleted";
    }
    {
      mode = [ "n" ];
      key = "]c";
      action = lib.nixvim.mkRaw "require('gitsigns').next_hunk";
      options.desc = "next change";
    }
    {
      mode = [ "n" ];
      key = "[c";
      action = lib.nixvim.mkRaw "require('gitsigns').prev_hunk";
      options.desc = "previous change";
    }
  ];
}
