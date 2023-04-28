local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- -- -- -- Autocommand that reloads neovim whenever you save the plugins.lua file
-- -- -- vim.cmd [[
-- -- --   augroup packer_user_config
-- -- --   autocmd!
-- -- --   autocmd BufWritePost plugins.lua source <afile> | Lazy sync
-- -- --   augroup end
-- -- -- ]]
-- -- --
-- -- -- Use a protected call so we don't error out on first use
-- -- local status_ok, packer = pcall(require, "packer")
-- -- if not status_ok then
-- --     return
-- -- end
-- --
-- -- Have packer use a popup window
-- packer.init {
--     display = {
--         open_fn = function()
--             return require("packer.util").float { border = "rounded" }
--         end,
--     },
-- }
--
require("lazy").setup({

    { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins

    { "Wansmer/treesj",
        dependencies = { "nvim-treesitter" },
        opts = {
            use_default_keymaps = false,-- (<space>m - toggle, <space>j - join, <space>s - split)
            check_syntax_error = true,
            max_join_length = 500,
            cursor_behavior = "hold",
            notify = true,
            langs = {--[[ configuration for languages ]]},
        }
    },

    { "numToStr/Comment.nvim",
        opts = {
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = { line = "gkk", block = "gbk" },
            opleader = { line = "gk", block = "gb" },
            extra = { above = "gcO", below = "gco", eol = "gcA" },
            mappings = { basic = true, extra = true },
            pre_hook = nil,
            post_hook = nil,
        }
    },

    { "ethanholz/nvim-lastplace",
        opts = {
            lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
            lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
            lastplace_open_folds = true
        }
    },

    { "stevearc/dressing.nvim",
        opts = {
            input = {
                enabled = true,
                default_prompt = "Input:",
                prompt_align = "left",
                insert_only = true,
                start_in_insert = true,
                anchor = "SW",
                border = "rounded",
                relative = "cursor",
                prefer_width = 40,
                width = nil,
                max_width = { 140, 0.9 },
                min_width = { 20, 0.2 },
                buf_options = {},
                win_options = {
                    winblend = 10,
                    wrap = false,
                },
                mappings = {
                    n = { ["<Esc>"] = "Close", ["<CR>"] = "Confirm" },
                    i = { ["<C-c>"] = "Close", ["<CR>"] = "Confirm", ["<Up>"] = "HistoryPrev", ["<Down>"] = "HistoryNext" },
                },
                override = function(conf) return conf end,
                get_config = nil,
            },
            select = {
                enabled = true,
                backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
                trim_prompt = true,
                telescope = nil,
                fzf = { window = { width = 0.5, height = 0.4 } },
                fzf_lua = { winopts = { width = 0.5, height = 0.4 } },
                nui = {
                    position = "50%",
                    size = nil,
                    relative = "editor",
                    border = { style = "rounded" },
                    buf_options = { swapfile = false, filetype = "DressingSelect" },
                    win_options = { winblend = 10 },
                    max_width = 80,
                    max_height = 40,
                    min_width = 40,
                    min_height = 10,
                },
                builtin = {
                    anchor = "NW",
                    border = "rounded",
                    relative = "editor",
                    buf_options = {},
                    win_options = { winblend = 10 },
                    width = nil,
                    max_width = { 140, 0.8 },
                    min_width = { 40, 0.2 },
                    height = nil,
                    max_height = 0.9,
                    min_height = { 10, 0.2 },
                    mappings = { ["<Esc>"] = "Close", ["<C-c>"] = "Close", ["<CR>"] = "Confirm" },
                    override = function(conf) return conf end,
                },
                format_item_override = {},
                get_config = nil,
            },
        }
    },

    { "jiaoshijie/undotree",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    { "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },

    { "kylechui/nvim-surround",
        opts = {}
    },

    { "lewis6991/gitsigns.nvim",
        opts = {
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 0
                },
                current_line_blame_formatter = "<author>, <abbrev_sha>, <author_time:%Y-%m-%d> - <summary>",
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    -- Navigation
                    vim.keymap.set("n", "]c", function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end, {expr=true})
                    vim.keymap.set("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, {expr=true})
                    vim.keymap.set({"n", "v"}, "<leader>as", gs.stage_hunk, {desc = "stage hunk"})
                    vim.keymap.set({"n", "v"}, "<leader>ar", gs.reset_hunk, {desc = "reset hunk"})
                    vim.keymap.set("n", "<leader>aS", gs.stage_buffer, {desc = "stage buffer"})
                    vim.keymap.set("n", "<leader>au", gs.undo_stage_hunk, {desc = "undo stage hunk"})
                    vim.keymap.set("n", "<leader>aR", gs.reset_buffer, {desc = "reset buffer"})
                    vim.keymap.set("n", "<leader>ap", gs.preview_hunk, {desc = "preview hunk"})
                    vim.keymap.set("n", "<leader>ab", function() gs.blame_line{full=true} end, {desc = "full blame"})
                    vim.keymap.set("n", "<leader>al", gs.toggle_current_line_blame, {desc = "toggle line blame"})
                    vim.keymap.set("n", "<leader>ad", gs.diffthis, {desc = "diff file"})
                    vim.keymap.set("n", "<leader>aD", function() gs.diffthis("~") end, {desc = "diff file with HEAD~"})
                    vim.keymap.set("n", "<leader>ax", gs.toggle_deleted, {desc = "toggle deleted"})
                end
            }
    },

    { "echasnovski/mini.pairs" },

    { "folke/which-key.nvim",
        opts = {}
    },

    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap"},
        opts = {}
    },

    { "tpope/vim-dispatch" },
    { "tpope/vim-fugitive" },

    -- Colorschemes
    { "lunarvim/colorschemes" }, -- A bunch of colorschemes you can try out
    { "vim-airline/vim-airline",
        lazy = false,
        dependencies = {
            "vim-airline/vim-airline-themes",
            "nvim-tree/nvim-web-devicons",
        },
    },
    { "EdenEast/nightfox.nvim",
        opts = { options = { transparent = true } }
    },

    { "catppuccin/nvim",
        name = "catppuccin",
        opts = { transparent_background = true }
    },

    { "nvim-tree/nvim-web-devicons" }, -- icons

    { "lukas-reineke/indent-blankline.nvim",
        opts = {
            show_current_context = true,
            show_current_context_start = true,
        }
    },

    -- cmp plugins
    { "hrsh7th/nvim-cmp" }, -- The completion plugin
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "hrsh7th/cmp-cmdline" }, -- cmdline completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" },

    -- snippets
    { "L3MON4D3/LuaSnip" }, --snippet engine
    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

    -- LSP
    { "neovim/nvim-lspconfig" }, -- enable LSP
    { "williamboman/nvim-lsp-installer" }, -- simple to use language server installer
    { "tamago324/nlsp-settings.nvim" }, -- language server settings defined in json for

    { "mfussenegger/nvim-jdtls",
        init = function()
            vim.api.nvim_create_autocmd({"FileType"}, {
                pattern = { "*.java" },
                callback = function ()
                    require("jdtls").start_or_attach({
                        cmd = {"/usr/bin/jdtls"},
                        root_dir = vim.fs.dirname(vim.fs.find({".gradlew", ".git", "mvnw"}, { upward = true })[1]),
                        settings = { java = { project = { referencedLibraries = {
                            "/home/philipp/.m2/repository/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar",
                        } } } }
                    })
                end
            })
        end
    },

    -- Telescope
    { "nvim-telescope/telescope.nvim",
        opts = {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--ignore-file",
                        ".gitignore"
                    },
                }
            }
    },

    { "ahmedkhalf/project.nvim",
        opts = {},
        config = function()
            require("telescope").load_extension("projects")
        end
    },

    { "ThePrimeagen/harpoon" },

    {
        "nvim-treesitter/nvim-treesitter",
        build = function() vim.cmd("TSUpdate") end,
        opts = {
            ensure_installed = "all",
            sync_install = false, 
            ignore_install = { "" }, -- List of parsers to ignore installing
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = { "" }, -- list of language that will be disabled
                additional_vim_regex_highlighting = true,
            },
            indent = { enable = true, disable = { "yaml" } },
        }
    },
    { "p00f/nvim-ts-rainbow" },
    { "nvim-treesitter/playground" },
    { "nvim-treesitter/nvim-treesitter-textobjects",
        config = function() require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["x"] = "@comment.outer"
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>wa"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>Wa"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]a"] = "@parameter.inner",
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        ["]A"] = "@parameter.inner",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[a"] = "@parameter.inner",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[A"] = "@parameter.inner",
                    },
                },
            }
        })
        end
    }

})
