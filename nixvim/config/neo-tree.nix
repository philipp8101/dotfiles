{
    plugins.neo-tree = {
        enable = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
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
                handler = {
                    # don't know if this is the proper way to pass lua code
                    # ref: https://github.com/nix-community/nixvim/blob/main/lib/to-lua.nix
                    __raw = ''
                        function(file_path)
                        require('neo-tree').close_all()
                        end;
                    '';
                };
            }
            ];
        };
    };
    keymaps = [
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
