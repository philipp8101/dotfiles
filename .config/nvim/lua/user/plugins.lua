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

    { "nvim-neo-tree/neo-tree.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        lazy = false,
        opts = {
            window = {
                mappings = {
                    ["n"] = "close_node",
                    ["e"] = "none",
                    ["o"] = "none",
                    ["i"] = "open",
                }
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        require("neo-tree").close_all()
                    end,
                }
            }
        },
    },

    { "Wansmer/treesj",
        dependencies = { "nvim-treesitter" },
        opts = {
            use_default_keymaps = false,-- (<space>m - toggle, <space>j - join, <space>s - split)
            check_syntax_error = true,
            max_join_length = 5000,
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


    { "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        },
        opts = {}
    },

    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap"},
        opts = {}
    },

    { "tpope/vim-dispatch" },
    { "tpope/vim-fugitive" },

    {
        "SmiteshP/nvim-navbuddy",
        lazy = false,
        dependencies = { "neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim", },
        config = function()
            local navbuddy = require("nvim-navbuddy")
            local actions = require("nvim-navbuddy.actions")
            navbuddy.setup({
                mappings = {
                    ["n"] = actions.parent(),           -- Move to left panel
                    ["e"] = actions.next_sibling(),     -- down
                    ["o"] = actions.previous_sibling(), -- up
                    ["i"] = actions.children(),         -- Move to right panel
                },
                lsp = {
                    auto_attach = true,
                },
            })
        end,
    },

    { "iamcco/markdown-preview.nvim",
	    build = "cd app && npm install",
	    config = function() vim.g.mkdp_filetypes = { "markdown" } end,
	    ft = "markdown",
    },

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
    { "L3MON4D3/LuaSnip",
    	opts = {
            history = true,
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave"
        }
    }, --snippet engine

    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
    { "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
    },
    { "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {},
                automatic_installation = {
                    exclude = {},
                }
            })

            require("mason-lspconfig").setup_handlers {
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
            }

            -- automatic_installation is handled by lsp-manager
            local settings = require "mason-lspconfig.settings"
            settings.current.automatic_installation = false
        end,
        lazy = true,
        dependencies = "mason.nvim",
    },
    { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
    { "jose-elias-alvarez/null-ls.nvim", lazy = true },
    { "williamboman/mason.nvim",
        opts = {
            {
                ui = {
                    check_outdated_packages_on_open = true,
                    width = 0.8,
                    height = 0.9,
                    border = "rounded",
                    keymaps = {
                        toggle_package_expand = "<CR>",
                        install_package = "i",
                        update_package = "u",
                        check_package_version = "c",
                        update_all_packages = "U",
                        check_outdated_packages = "C",
                        uninstall_package = "X",
                        cancel_installation = "<C-c>",
                        apply_language_filter = "<C-f>",
                    },
                },
                icons = {
                    package_installed = "◍",
                    package_pending = "◍",
                    package_uninstalled = "◍",
                },
                -- NOTE: should be available in $PATH
                install_root_dir = table.concat({ vim.fn.stdpath "data", "mason" }, "/"),
                -- NOTE: already handled in the bootstrap stage
                PATH = "skip",
                pip = {
                    upgrade_pip = false,
                    -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
                    -- and is not recommended.
                    --
                    -- Example: { "--proxy", "https://proxyserver" }
                    install_args = {},
                },
                -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
                -- debugging issues with package installations.
                log_level = vim.log.levels.INFO,
                -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
                -- packages that are requested to be installed will be put in a queue.
                max_concurrent_installers = 4,
                -- [Advanced setting]
                -- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
                -- multiple registries, the registry listed first will be used.
                registries = {
                    "lua:mason-registry.index",
                    "github:mason-org/mason-registry",
                },
                -- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
                -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
                providers = {
                    "mason.providers.registry-api",
                    "mason.providers.client",
                },
                github = {
                    -- The template URL to use when downloading assets from GitHub.
                    -- The placeholders are the following (in order):
                    -- 1. The repository (e.g. "rust-lang/rust-analyzer")
                    -- 2. The release version (e.g. "v0.3.0")
                    -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
                    download_url_template = "https://github.com/%s/releases/download/%s/%s",
                },
                on_config_done = nil,
            }
        },
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        build = function()
            pcall(function()
                require("mason-registry").refresh()
            end)
        end,
        lazy = true,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function ()
            local null_ls = require("null-ls")
            null_ls.setup({
                debug = true,
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.eslint_d,
                    -- null_ls.builtins.diagnostics.shellcheck,
                },
            })
        end,
        lazy = false,
    },

    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        opts = {
            ensure_installed = {},
            automatic_setup = true,
            handlers = {},
        },
    },

    { "folke/neodev.nvim",
        opts = {}
    },

    { "mrcjkb/haskell-tools.nvim",
        lazy = false,
        opts = {},
        dependencies = {
             'nvim-lua/plenary.nvim',
             'nvim-telescope/telescope.nvim',
         },
    },
    { "neovimhaskell/haskell-vim",
        config = function()
            vim.g.haskell_enable_quantification = 1   -- to enable highlighting of `forall`
            vim.g.haskell_enable_recursivedo = 1      -- to enable highlighting of `mdo` and `rec`
            vim.g.haskell_enable_arrowsyntax = 1      -- to enable highlighting of `proc`
            vim.g.haskell_enable_pattern_synonyms = 1 -- to enable highlighting of `pattern`
            vim.g.haskell_enable_typeroles = 1        -- to enable highlighting of type roles
            vim.g.haskell_enable_static_pointers = 1  -- to enable highlighting of `static`
            vim.g.haskell_backpack = 1                -- to enable highlighting of backpack keywords
        end
    },

    { "mfussenegger/nvim-jdtls" },

    -- Telescope
    { "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                },
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

    { "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                    local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
                    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
                    local enabled = false
                    opts.textobjects = {
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
                    require("nvim-treesitter.configs").setup(opts)
                    if opts.textobjects then
                        for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                            if opts.textobjects[mod] and opts.textobjects[mod].enable then
                                enabled = true
                                break
                            end
                        end
                    end
                    if not enabled then
                        require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                    end
                end,
            },
        },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        ---@type TSConfig
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                "bash",
                "c",
                "html",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
    }

})
