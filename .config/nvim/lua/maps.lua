-- from https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/keymaps.lua
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-p>", "<C-]>", opts)
keymap("n", "<C-j>", ":m+1<CR>", opts)
keymap("n", "<C-k>", ":m-2<CR>", opts)
keymap("v", "<C-j>", ":m'>+<CR>", opts)
keymap("v", "<C-k>", ":m-2<CR>", opts)
keymap("n", "<C-d>", "<C-d> zz", opts)
keymap("n", "<C-u>", "<C-u> zz", opts)

