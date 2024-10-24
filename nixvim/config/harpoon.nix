{
  plugins.harpoon = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>l";
      action.__raw = ''function() require("harpoon.mark").add_file() end'';
      options.desc = "add file to harpoon";
    }
    {
      key = "<leader>L";
      action.__raw = ''function() require("harpoon.ui").toggle_quick_menu() end'';
      options.desc = "open harpoon menu";
    }
    {
      key = "<leader>n";
      action.__raw = ''function() require("harpoon.ui").nav_file(1) end'';
      options.desc = "open file 1";
    }
    {
      key = "<leader>e";
      action.__raw = ''function() require("harpoon.ui").nav_file(2) end'';
      options.desc = "open file 2";
    }
    {
      key = "<leader>o";
      action.__raw = ''function() require("harpoon.ui").nav_file(3) end'';
      options.desc = "open file 3";
    }
    {
      key = "<leader>i";
      action.__raw = ''function() require("harpoon.ui").nav_file(4) end'';
      options.desc = "open file 4";
    }
    {
      key = "<leader>N";
      action.__raw = ''function() require("harpoon.term").gotoTerminal(1) end'';
      options.desc = "open terminal 1";
    }
    {
      key = "<leader>E";
      action.__raw = ''function() require("harpoon.term").gotoTerminal(2) end'';
      options.desc = "open terminal 2";
    }
    {
      key = "<leader>O";
      action.__raw = ''function() require("harpoon.term").gotoTerminal(3) end'';
      options.desc = "open terminal 3";
    }
    {
      key = "<leader>I";
      action.__raw = ''function() require("harpoon.term").gotoTerminal(4) end'';
      options.desc = "open terminal 4";
    }
  ];
}
