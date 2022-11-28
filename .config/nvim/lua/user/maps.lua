-- from https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/keymaps.lua
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-p>", "<C-]>", opts)
keymap("n", "<C-d>", "<C-d> zz", opts)
keymap("n", "<C-u>", "<C-u> zz", opts)
keymap("n", "<leader>f", ":Telescope find_files <CR>", opts)
keymap("n", "<leader>g", ":Telescope live_grep <CR>", opts)
keymap("n", "<leader>l", ":lua require(\"harpoon.ui\").toggle_quick_menu() <CR>", opts)
keymap("n", "<leader>d", ":lua require(\"harpoon.mark\").add_file() <CR>", opts)
keymap("n", "<leader>h", ":lua require(\"harpoon.ui\").nav_file(1) <CR>", opts)
keymap("n", "<leader>t", ":lua require(\"harpoon.ui\").nav_file(2) <CR>", opts)
keymap("n", "<leader>n", ":lua require(\"harpoon.ui\").nav_file(3) <CR>", opts)
keymap("n", "<leader>s", ":lua require(\"harpoon.ui\").nav_file(4) <CR>", opts)
keymap("n", "gs", ":TSJSplit <CR>", opts)
keymap("n", "gj", ":TSJJoin <CR>", opts)
keymap("n", "<C-h>", ":m-2 <CR>", opts)
keymap("n", "<C-l>", ":m+1 <CR>", opts)
keymap("x", "<C-h>", ":m-2 <CR>gv=gv", opts)
keymap("x", "<C-l>", ":m'>+ <CR>gv=gv", opts)
keymap("n", "gr", ":Telescope lsp_references <CR>", opts)
