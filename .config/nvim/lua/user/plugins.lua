local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    use({
        'Wansmer/treesj',
        requires = { 'nvim-treesitter' },
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,-- (<space>m - toggle, <space>j - join, <space>s - split)
                check_syntax_error = true,
                max_join_length = 500,
                cursor_behavior = 'hold',
                notify = true,
                langs = {--[[ configuration for languages ]]},
            })
        end,
    })

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                padding = true,
                sticky = true,
                ignore = nil,
                toggler = { line = 'gcc', block = 'gbc' },
                opleader = { line = 'gc', block = 'gb' },
                extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
                mappings = { basic = true, extra = true },
                pre_hook = nil,
                post_hook = nil,
            })
        end
    }

    use { 'ethanholz/nvim-lastplace',
        config = function()
            require'nvim-lastplace'.setup({
                lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
                lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
                lastplace_open_folds = true
            })
        end
    }

    use {"akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("toggleterm").setup()
    end}

    use {'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup({
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
            })
        end
    }

    use { 'mrjones2014/legendary.nvim' }

    use { "jiaoshijie/undotree",
        config = function() require('undotree').setup() end,
        requires = { "nvim-lua/plenary.nvim" },
    }

    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    use { "kylechui/nvim-surround",
        tag = "*",
        config = function() require("nvim-surround").setup({ }) end
    }

    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use({  "folke/zen-mode.nvim" })
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {

            }
        end
    }

    use { 'mfussenegger/nvim-dap' }
    use { "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap"},
        config = function()
            require("dapui").setup()
        end
    }

    use "tpope/vim-dispatch"

    -- Colorschemes
    use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use "EdenEast/nightfox.nvim"
    --[[ use({ 'xiyaowong/nvim-transparent'}) ]]


    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for

    use { 'mfussenegger/nvim-jdtls',
        config = function()
            vim.api.nvim_create_autocmd({"FileType"}, {
                pattern = { "*.java" },
                callback = function ()
                    require('jdtls').start_or_attach({
                        cmd = {'/usr/bin/jdtls'},
                        root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
                        settings = { java = { project = { referencedLibraries = {
                            '/home/philipp/.m2/repository/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar',
                        } } } }
                    })
                end
            })
        end
    }

    -- Telescope
    use { "nvim-telescope/telescope.nvim",
        config = function()
            require('telescope').setup{
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--ignore-file',
                        '.gitignore'
                    },
                }
            }
    end
    }

    use { "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
            }
            require('telescope').load_extension('projects')
        end
    }

    --harpoon
    use "ThePrimeagen/harpoon"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "p00f/nvim-ts-rainbow"
    use "nvim-treesitter/playground"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
