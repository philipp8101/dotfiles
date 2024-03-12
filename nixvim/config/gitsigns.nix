{
    # config.diff_opts.internal = true;
    plugins.gitsigns = {
        enable = true;
        # wordDiff = true;
        signcolumn = true;
    };
    keymaps = [
				{
                    mode = ["n"];
                    key = "<leader>as";
                    lua = true;
                    action = ''require("gitsigns").stage_hunk'';
                    options.desc = "stage hunk";
                }
				{
                    mode = ["v"];
                    key = "<leader>as";
                    action = ''<cmd>Gitsigns stage_hunk <CR>'';
                    options.desc = "stage hunk";
                }
				{
                    mode = ["n" "v"];
                    key = "<leader>ar";
                    lua = true;
                    action = ''require("gitsigns").reset_hunk'';
                    options.desc = "reset hunk";
                }
				{
                    mode = ["n"];
                    key = "<leader>aS";
                    lua = true;
                    action = ''require("gitsigns").stage_buffer'';
                    options.desc = "stage buffer";
                }
				{
                    mode = ["n"];
                    key = "<leader>au";
                    lua = true;
                    action = ''require("gitsigns").undo_stage_hunk'';
                    options.desc = "undo stage hunk";
                }
				{
                    mode = ["n"];
                    key = "<leader>aR";
                    lua = true;
                    action = ''require("gitsigns").reset_buffer'';
                    options.desc = "reset buffer";
                }
				{
                    mode = ["n"];
                    key = "<leader>ap";
                    lua = true;
                    action = ''require("gitsigns").preview_hunk'';
                    options.desc = "preview hunk";
                }
				{
                    mode = ["n"];
                    key = "<leader>ab";
                    lua = true;
                    action = ''function() require("gitsigns").blame_line({ full = true }) end'';
                    options.desc = "full blame";
                }
				{
                    mode = ["n"];
                    key = "<leader>al";
                    lua = true;
                    action = ''require("gitsigns").toggle_current_line_blame'';
                    options.desc = "toggle line blame";
                }
				{
                    mode = ["n"];
                    key = "<leader>ad";
                    lua = true;
                    action = ''require("gitsigns").diffthis'';
                    options.desc = "diff file";
                }
				{
                    mode = ["n"];
                    key = "<leader>aD";
                    lua = true;
                    action = ''function() require("gitsigns").diffthis("~") end'';
                    options.desc = "diff file with HEAD~";
                }
				{
                    mode = ["n"];
                    key = "<leader>ax";
                    lua = true;
                    action = ''require("gitsigns").toggle_deleted'';
                    options.desc = "toggle deleted";
                }
    ];
}
