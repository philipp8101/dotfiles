{
    config = {
        keymaps = [
            {
                key = "<C-f>";
                action = "<cmd>Telescope find_files<CR>";
                options.desc = "Fuzzy find files";
            }
            { key = "<C-d>"; action = "<C-d>zz"; }
            { key = "<C-u>"; action = "<C-u>zz"; }
            { key = "n"; action = "nzz"; }
            { key = "N"; action = "Nzz"; }
            {
                key = "<C-k>";
                action = "<cmd>m-2 <CR>";
                options.desc = "move line up";
            }
            {
                key = "<C-j>";
                action = "<cmd>m+1 <CR>";
                options.desc = "move line down";
            }
            # { mode = "x"; key = "<C-k>"; action = "<cmd>m-2 <CR>gv=gv"; }
            # { mode = "x"; key = "<C-j>"; action = "<cmd>m'>+ <CR>gv=gv"; }
            # not working
            {
                mode = [ "n" "v" ];
                key = "<leader>y";
                action = "\"+y";
                options.desc = "yank to system clipboard";
            }
            {
                mode = [ "n" "v" ];
                key = "<leader>p";
                action = "\"+p";
                options.desc = "paste from system clipboard";
            }
            {
                key = "<C-q>";
                action = "<cmd>cclose<CR><cmd>lclose<CR>";
                options.desc = "close quickfix and location list";
            }
            {
                key = "<C-n>";
                action = "<cmd>cnext<CR>";
                options.desc = "next item in quickfix";
            }
            {
                key = "<C-p>";
                action = "<cmd>cprev<CR>";
                options.desc = "previous item in quickfix";
            }
            {
                key = "<C-f>";
                action = "<cmd>lnext<CR>";
                options.desc = "next item in locationlist";
            }
            {
                key = "<C-l>";
                action = "<cmd>lprev<CR>";
                options.desc = "previous item in locationlist";
            }
        ];
        autoCmd = [
            # { event = [ "" ]; pattern = [ "*" ]; command = ""; }
        ];
    };
}
