-- from https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/keymaps.lua
local opts = { noremap = true, silent = true }
local legendaryPresent, _ = pcall(require, 'legendary')
local lspPresent, _ = pcall(require, 'lsp')

KeymapTable = {}
local function keymap(mode, key, map, opt, desc, isLsp)
	if not legendaryPresent then
		vim.api.nvim_set_keymap(mode, key, map, opt)
	else
		local m = {}
		m[mode] = map
		table.insert(KeymapTable, { key, m, description = desc, opt })
	end
end

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-p>", "<C-]>", opts, "follow link eg. help pages")
keymap("n", "<C-d>", "<C-d> zz", opts, "move a half-page down and center the cursor")
keymap("n", "<C-u>", "<C-u> zz", opts, "move a half-page up and center the cursor")

keymap("n", "<leader>l", ":lua require(\"harpoon.ui\").toggle_quick_menu() <CR>", opts, "open harpoon menu")
keymap("n", "<leader>d", ":lua require(\"harpoon.mark\").add_file() <CR>", opts, "add current file to harpoon list")
keymap("n", "<leader>h", ":lua require(\"harpoon.ui\").nav_file(1) <CR>", opts, "Navigate to the first pinned file with harpoon")
keymap("n", "<leader>t", ":lua require(\"harpoon.ui\").nav_file(2) <CR>", opts, "Navigate to the second pinned file with harpoon")
keymap("n", "<leader>n", ":lua require(\"harpoon.ui\").nav_file(3) <CR>", opts, "Navigate to the third pinned file with harpoon")
keymap("n", "<leader>s", ":lua require(\"harpoon.ui\").nav_file(4) <CR>", opts, "Navigate to the fourth pinned file with harpoon")
keymap("n", "<leader>e", ":Ex <CR>", opts, "Open File Browser (netrw)")
keymap("n", "<leader>u", ":lua require('undotree').toggle() <CR>", opts, "Open undotree")

keymap("n", "gs", ":TSJSplit <CR>", opts, "split a block of code, such as arrays or arguments, in multiple lines" )
keymap("n", "gj", ":TSJJoin <CR>", opts, "consolidate a block of code, such as arrays or arguments, into a single line")

keymap("n", "<C-h>", ":m-2 <CR>", opts, "move the current line up")
keymap("n", "<C-l>", ":m+1 <CR>", opts, "move the current line down")
keymap("x", "<C-h>", ":m-2 <CR>gv=gv", opts, "move the visually selected lines up")
keymap("x", "<C-l>", ":m'>+ <CR>gv=gv", opts, "move the visually selected lines down")

keymap("n", "<leader>f", ":Telescope find_files <CR>", opts, "open file search with Telescope")
keymap("n", "<leader>g", ":Telescope live_grep <CR>", opts, "search project with Telescope(ripgrep)")

-- toggleterm.nvim bindings
keymap("n", "<leader>c", ":ToggleTerm direction=float <CR>", opts, "open a floating terminal")
keymap("t", "<C-d>", "<C-\\><C-n>:ToggleTerm direction=float <CR>", opts, "close a floating terminal")

if legendaryPresent then
	require('legendary').setup({ keymaps = KeymapTable, commands = {}, funcs = {}, autocmds = {} })
end
