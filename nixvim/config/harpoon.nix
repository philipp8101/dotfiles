{
    plugins.harpoon = {
        enable = true;
    };
    keymaps = [
        {
            key = "<leader>l";
            action = ''function() require("harpoon.mark").add_file() end'';
            lua = true;
            options.desc = "add file to harpoon";
        }
        {
            key = "<leader>L";
            action = ''function() require("harpoon.ui").toggle_quick_menu() end'';
            lua = true;
            options.desc = "open harpoon menu";
        }
        {
            key = "<leader>n";
            action = ''function() require("harpoon.ui").nav_file(1) end'';
            lua = true;
            options.desc = "open file 1";
        }
        {
            key = "<leader>e";
            action = ''function() require("harpoon.ui").nav_file(2) end'';
            lua = true;
            options.desc = "open file 2";
        }
        {
            key = "<leader>o";
            action = ''function() require("harpoon.ui").nav_file(3) end'';
            lua = true;
            options.desc = "open file 3";
        }
        {
            key = "<leader>i";
            action = ''function() require("harpoon.ui").nav_file(4) end'';
            lua = true;
            options.desc = "open file 4";
        }
        {
            key = "<leader>N";
            action = ''function() require("harpoon.ui").gotoTerminal(1) end'';
            lua = true;
            options.desc = "open terminal 1";
        }
        {
            key = "<leader>E";
            action = ''function() require("harpoon.ui").gotoTerminal(2) end'';
            lua = true;
            options.desc = "open terminal 2";
        }
        {
            key = "<leader>O";
            action = ''function() require("harpoon.ui").gotoTerminal(3) end'';
            lua = true;
            options.desc = "open terminal 3";
        }
        {
            key = "<leader>I";
            action = ''function() require("harpoon.ui").gotoTerminal(4) end'';
            lua = true;
            options.desc = "open terminal 4";
        }
    ];
}
