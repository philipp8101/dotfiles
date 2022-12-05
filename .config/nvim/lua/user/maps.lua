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

keymap("n", "<leader>l", ":lua require(\"harpoon.ui\").toggle_quick_menu() <CR>", opts)
keymap("n", "<leader>d", ":lua require(\"harpoon.mark\").add_file() <CR>", opts)
keymap("n", "<leader>h", ":lua require(\"harpoon.ui\").nav_file(1) <CR>", opts)
keymap("n", "<leader>t", ":lua require(\"harpoon.ui\").nav_file(2) <CR>", opts)
keymap("n", "<leader>n", ":lua require(\"harpoon.ui\").nav_file(3) <CR>", opts)
keymap("n", "<leader>s", ":lua require(\"harpoon.ui\").nav_file(4) <CR>", opts)
keymap("n", "<leader>e", ":Ex <CR>", opts)

keymap("n", "gs", ":TSJSplit <CR>", opts)
keymap("n", "gj", ":TSJJoin <CR>", opts)

keymap("n", "<C-h>", ":m-2 <CR>", opts)
keymap("n", "<C-l>", ":m+1 <CR>", opts)
keymap("x", "<C-h>", ":m-2 <CR>gv=gv", opts)
keymap("x", "<C-l>", ":m'>+ <CR>gv=gv", opts)

keymap("n", "<leader>f", ":Telescope find_files <CR>", opts)
keymap("n", "<leader>g", ":Telescope live_grep <CR>", opts)

-- toggleterm.nvim bindings
keymap("n", "<leader>c", ":ToggleTerm direction=float <CR>", opts)
keymap("t", "<C-d>", "<C-\\><C-n>:ToggleTerm direction=float <CR>", opts)

--[[ TODO convert keybindings to legendary conf 
	 TODO generate default bindings from legendary conf or some other common format
require('legendary').setup({
  keymaps = {
    -- map keys to a command
    { '<leader>ff', ':Telescope find_files', description = 'Find files' },
    -- map keys to a function
    { '<leader>h', function() print('hello world!') end, description = 'Say hello' },
    -- keymaps have opts.silent = true by default, but you can override it
    { '<leader>s', ':SomeCommand<CR>', description = 'Non-silent keymap', opts = { silent = false } },
    -- create keymaps with different implementations per-mode
    {
      '<leader>c',
      { n = ':LinewiseCommentToggle<CR>', x = ":'<,'>BlockwiseCommentToggle<CR>" },
      description = 'Toggle comment'
    },
    -- create item groups to create sub-menus in the finder
    -- note that only keymaps, commands, and functions
    -- can be added to item groups
    {
      -- groups with same itemgroup will be merged
      itemgroup = 'short ID',
      description = 'A submenu of items...',
      icon = '',
      keymaps = {
        -- more keymaps here
      },
    },
  },
  commands = {
    -- easily create user commands
    { ':SayHello', function() print('hello world!') end, description = 'Say hello as a command' },
    {
      -- groups with same itemgroup will be merged
      itemgroup = 'short ID',
      -- don't need to copy the other group data because
      -- it will be merged with the one from the keymaps table
      commands = {
        -- more commands here
      },
    },
  },
  funcs = {
    -- Make arbitrary Lua functions that can be executed via the item finder
    { function() doSomeStuff() end, description = 'Do some stuff with a Lua function!' },
    {
      -- groups with same itemgroup will be merged
      itemgroup = 'short ID',
      -- don't need to copy the other group data because
      -- it will be merged with the one from the keymaps table
      funcs = {
        -- more funcs here
      },
    },
  },
  autocmds = {
    -- Create autocmds and augroups
    { 'BufWritePre', vim.lsp.buf.format, description = 'Format on save' },
    {
      name = 'MyAugroup',
      clear = true,
      -- autocmds here
    },
  },
}) ]]
