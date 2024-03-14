{
    plugins.trouble = {
        enable = true;
    };
    keymaps = [
        {
            key = "<leader>dt";
            action = ''function() require("trouble").toggle(); end'';
            lua = true;
            options.desc = "open workspace diagnostics";
        }
        {
            key = "]d";
            action = ''function() require("trouble").next({skip_groups = true, jump = true}); end'';
            lua = true;
            options.desc = "next workspace diagnostic";
        }
        {
            key = "[d";
            action = ''function() require("trouble").previous({skip_groups = true, jump = true}); end'';
            lua = true;
            options.desc = "previous workspace diagnostic";
        }
    ];
}
