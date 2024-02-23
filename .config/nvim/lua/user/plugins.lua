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

require("lazy").setup({

	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		lazy = true,
		cmd = "Neotree",
		opts = {
			popup_border_style = "rounded",
			window = {
				mappings = {
					["n"] = "close_node",
					["e"] = "none",
					["o"] = "none",
					["i"] = "open",
					["<leader>as"] = "git_add_file",
					["<leader>au"] = "git_unstage_file",
					["og"] = "noop",
					["ot"] = "noop",
					["os"] = "noop",
					["om"] = "noop",
					["on"] = "noop",
					["od"] = "noop",
					["oc"] = "noop",
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						require("neo-tree").close_all()
					end,
				},
			},
		},
	},

	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		lazy = true,
		cmd = "Neorg",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jbyuki/nabla.nvim",
		},
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
						default_workspace = "notes",
					},
				},
			},
		},
	},

	{
		"jbyuki/nabla.nvim",
		lazy = true,
		config = function()
			vim.api.nvim_create_autocmd({ "InsertEnter" }, {
				pattern = { "*.norg" },
				callback = function()
					require("nabla").disable_virt()
				end,
			})
			vim.api.nvim_create_autocmd({ "InsertLeave" }, {
				pattern = { "*.norg" },
				callback = function()
					require("nabla").enable_virt()
				end,
			})
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				pattern = { "*.norg" },
				callback = function()
					require("nabla").enable_virt()
				end,
			})
			vim.api.nvim_create_autocmd({ "TextChanged" }, {
				pattern = { "*.norg" },
				callback = function()
					require("nabla").disable_virt()
					require("nabla").enable_virt()
				end,
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
		ft = {
			"astro",
			"glimmer",
			"handlebars",
			"html",
			"javascript",
			"jsx",
			"markdown",
			"php",
			"rescript",
			"svelte",
			"tsx",
			"typescript",
			"vue",
			"xml",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = true,
		cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
		opts = {},
	},

	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		lazy = true,
		cmd = { "TSJJoin", "TSJSplit" },
		opts = {
			use_default_keymaps = false, -- (<space>m - toggle, <space>j - join, <space>s - split)
			check_syntax_error = true,
			max_join_length = 5000,
			cursor_behavior = "hold",
			notify = true,
			langs = {--[[ configuration for languages ]]
			},
		},
	},

	{
		"numToStr/Comment.nvim",
		lazy = false,
		keys = { "gkk", "gbk", "gk", "gb", "gcO", "gco", "gcA" },
		-- doesn't account for combinations like vgkk
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
		},
	},

	{
		"ethanholz/nvim-lastplace",
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
	},

	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				enabled = true,
				default_prompt = "Input:",
				prompt_align = "left",
				insert_only = true,
				start_in_insert = true,
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
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
					},
				},
				override = function(conf)
					return conf
				end,
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
					override = function(conf)
						return conf
					end,
				},
				format_item_override = {},
				get_config = nil,
			},
		},
	},

	{
		"jiaoshijie/undotree",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		keys = "<leader>u",
		opts = {},
	},

	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		lazy = true,
		cmd = {
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
	},

	{
		"kylechui/nvim-surround",
		lazy = true,
		keys = { "ys", "ds", "cs" },
		opts = {},
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 0,
			},
			current_line_blame_formatter = "<author>, <abbrev_sha>, <author_time:%Y-%m-%d> - <summary>",
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				-- Navigation
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
				vim.keymap.set("n", "<leader>as", gs.stage_hunk, { desc = "stage hunk" })
				vim.keymap.set("v", "<leader>as", ":Gitsigns stage_hunk <CR>", { desc = "stage hunk" })
				vim.keymap.set({ "n", "v" }, "<leader>ar", gs.reset_hunk, { desc = "reset hunk" })
				vim.keymap.set("n", "<leader>aS", gs.stage_buffer, { desc = "stage buffer" })
				vim.keymap.set("n", "<leader>au", gs.undo_stage_hunk, { desc = "undo stage hunk" })
				vim.keymap.set("n", "<leader>aR", gs.reset_buffer, { desc = "reset buffer" })
				vim.keymap.set("n", "<leader>ap", gs.preview_hunk, { desc = "preview hunk" })
				vim.keymap.set("n", "<leader>ab", function()
					gs.blame_line({ full = true })
				end, { desc = "full blame" })
				vim.keymap.set("n", "<leader>al", gs.toggle_current_line_blame, { desc = "toggle line blame" })
				vim.keymap.set("n", "<leader>ad", gs.diffthis, { desc = "diff file" })
				vim.keymap.set("n", "<leader>aD", function()
					gs.diffthis("~")
				end, { desc = "diff file with HEAD~" })
				vim.keymap.set("n", "<leader>ax", gs.toggle_deleted, { desc = "toggle deleted" })
			end,
		},
	},

	{ "echasnovski/mini.pairs" },

	{ "folke/which-key.nvim", opts = {} },

	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
		opts = {},
	},

	{ "mfussenegger/nvim-dap" },

	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		keys = "<leader>d",
		dependencies = {
			"mfussenegger/nvim-dap",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		opts = {},
	},

	{ "tpope/vim-dispatch" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-sleuth" },
	{ "ggandor/leap.nvim" },

	{
		"SmiteshP/nvim-navbuddy",
		dependencies = { "neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
		lazy = true,
		cmd = "Navbuddy",
		config = function()
			local navbuddy = require("nvim-navbuddy")
			local actions = require("nvim-navbuddy.actions")
			navbuddy.setup({
				mappings = {
					["n"] = actions.parent(),
					["e"] = actions.next_sibling(),
					["o"] = actions.previous_sibling(),
					["i"] = actions.children(),
				},
				lsp = {
					auto_attach = true,
				},
			})
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		lazy = false,
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},

	{
		"vim-airline/vim-airline",
		lazy = false,
		dependencies = {
			"vim-airline/vim-airline-themes",
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"EdenEast/nightfox.nvim",
		opts = {
			options = { transparent = true },
		},
	},

	{ "nvim-tree/nvim-web-devicons" }, -- icons

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*" },
				callback = function(_)
					require("colorizer").setup()
				end,
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },

	{ "tpope/vim-dadbod" },

	{
		"kristijanhusak/vim-dadbod-ui",
		lazy = true,
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
	},

	{
		"kristijanhusak/vim-dadbod-completion",
		config = function()
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
				end,
			})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		opts = {
			history = true,
			region_check_events = "InsertEnter",
			delete_check_events = "TextChanged,InsertLeave",
		},
	},

	{ "rafamadriz/friendly-snippets" },

	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-lspconfig.nvim" },
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = {
					exclude = {},
				},
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({})
				end,
			})

			-- automatic_installation is handled by lsp-manager
			local settings = require("mason-lspconfig.settings")
			settings.current.automatic_installation = false
		end,
		dependencies = "mason.nvim",
	},

	{
		"williamboman/mason.nvim",
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
				install_root_dir = table.concat({ vim.fn.stdpath("data"), "mason" }, "/"),
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
			},
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
		"mfussenegger/nvim-lint",
		lazy = true,
		ft = { "php", "blade", "javascript", "typescript" },
		config = function()
			require("lint").linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				php = { "tlint" },
				blade = { "tlint" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				cmake = { "cmakelang" },
				python = { "pylint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "black" },
				bash = { "beautysh" },
				sh = { "beautysh" },
				zsh = { "beautysh" },
				latex = { "latexindent" },
				cmake = { "cmakelang" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		},
	},

	{
		"folke/neodev.nvim",
		opts = {},
	},

	{
		"neovimhaskell/haskell-vim",
		lazy = true,
		ft = "haskell",
		config = function()
			vim.g.haskell_enable_quantification = 1 -- to enable highlighting of `forall`
			vim.g.haskell_enable_recursivedo = 1 -- to enable highlighting of `mdo` and `rec`
			vim.g.haskell_enable_arrowsyntax = 1 -- to enable highlighting of `proc`
			vim.g.haskell_enable_pattern_synonyms = 1 -- to enable highlighting of `pattern`
			vim.g.haskell_enable_typeroles = 1 -- to enable highlighting of type roles
			vim.g.haskell_enable_static_pointers = 1 -- to enable highlighting of `static`
			vim.g.haskell_backpack = 1 -- to enable highlighting of backpack keywords
		end,
	},

	{
		"psiska/telescope-hoogle.nvim",
		lazy = true,
		ft = "haskell",
		config = function()
			require("telescope").load_extension("hoogle")
		end,
	},

	{
		"Civitasv/cmake-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		ft = { "cpp", "c" },
	},

	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		ft = "java",
	},

	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		opts = {
			defaults = {
				file_ignore_patterns = {
					-- some characters must be escaped in lua with %
					"node%_modules",
					".git",
					"dist%-newstyle",
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
			},
			extensions = {
				hoogle = {
					render = "default", -- Select the preview render engine: default|treesitter
					-- default = simple approach to render the document
					-- treesitter = render the document by utilizing treesitter's html parser
					renders = { -- Render specific options
						treesitter = {
							remove_wrap = false, -- Remove hoogle's own text wrapping. E.g. if you uses neovim's buffer wrapping
							-- (autocmd User TelescopePreviewerLoaded setlocal wrap)
						},
					},
				},
			},
		},
	},

	{ "ThePrimeagen/harpoon" },

	{
		"nvim-treesitter/nvim-treesitter",
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
								["x"] = "@comment.outer",
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
	},
})
