{ pkgs, ... }:
{
  plugins.harpoon = {
    enable = true;
    package = pkgs.vimPlugins.harpoon2;
  };
  keymaps = [
    {
      key = "<leader>l";
      action.__raw = ''function() require("harpoon"):list():add() end'';
      options.desc = "add current buffer to harpoon";
    }
    {
      key = "<leader>L";
      action.__raw = ''function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end'';
      options.desc = "open harpoon menu";
    }
    {
      key = "<leader>n";
      action.__raw = ''function() require("harpoon"):list():select(1) end'';
      options.desc = "open harpoon entry 1";
    }
    {
      key = "<leader>e";
      action.__raw = ''function() require("harpoon"):list():select(2) end'';
      options.desc = "open harpoon entry 2";
    }
    {
      key = "<leader>o";
      action.__raw = ''function() require("harpoon"):list():select(3) end'';
      options.desc = "open harpoon entry 3";
    }
    {
      key = "<leader>i";
      action.__raw = ''function() require("harpoon"):list():select(4) end'';
      options.desc = "open harpoon entry 4";
    }
    {
      key = "<leader>N";
      action.__raw = ''function() require("harpoon"):list():select(5) end'';
      options.desc = "open harpoon entry 5";
    }
    {
      key = "<leader>E";
      action.__raw = ''function() require("harpoon"):list():select(6) end'';
      options.desc = "open harpoon entry 6";
    }
    {
      key = "<leader>O";
      action.__raw = ''function() require("harpoon"):list():select(7) end'';
      options.desc = "open harpoon entry 7";
    }
    {
      key = "<leader>I";
      action.__raw = ''function() require("harpoon"):list():select(8) end'';
      options.desc = "open harpoon entry 8";
    }
  ];
}
