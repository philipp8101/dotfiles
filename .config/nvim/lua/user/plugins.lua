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
				-- Use default keymaps
				-- (<space>m - toggle, <space>j - join, <space>s - split)
				use_default_keymaps = false,

				-- Node with syntax error will not be formatted
				check_syntax_error = true,

				-- If line after join will be longer than max value,
				-- node will not be formatted
				max_join_length = 120,

				-- hold|start|end:
				-- hold - cursor follows the node/place on which it was called
				-- start - cursor jumps to the first symbol of the node being formatted
				-- end - cursor jumps to the last symbol of the node being formatted
				cursor_behavior = 'hold',

				-- Notify about possible problems or not
				notify = true,
				langs = {--[[ configuration for languages ]]},
			})
		end,
	})

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup({
				---Add a space b/w comment and the line
				padding = true,
				---Whether the cursor should stay at its position
				sticky = true,
				---Lines to be ignored while (un)comment
				ignore = nil,
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					---Line-comment toggle keymap
					line = 'gcc',
					---Block-comment toggle keymap
					block = 'gbc',
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					---Line-comment keymap
					line = 'gc',
					---Block-comment keymap
					block = 'gb',
				},
				---LHS of extra mappings
				extra = {
					---Add comment on the line above
					above = 'gcO',
					---Add comment on the line below
					below = 'gco',
					---Add comment at the end of line
					eol = 'gcA',
				},
				---Enable keybindings
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
				---Function to call before (un)comment
				pre_hook = nil,
				---Function to call after (un)comment
				post_hook = nil,
			})
		end
	}

	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

	-- Colorschemes
	use "folke/tokyonight.nvim"
	use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'

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

	-- Telescope
	use "nvim-telescope/telescope.nvim"

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
