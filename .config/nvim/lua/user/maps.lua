-- from https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/keymaps.lua
local opts = { noremap = true, silent = true }
local legendaryPresent, _ = pcall(require, 'legendary')

KeymapTable = {}
local function keymap(mode, key, map, opt, desc)
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
keymap("n", "<C-d>", "<C-d>zz", opts, "move a half-page down and center the cursor")
keymap("n", "<C-u>", "<C-u>zz", opts, "move a half-page up and center the cursor")

keymap("n", "n", "nzz", opts, "move a half-page up and center the cursor")
keymap("n", "N", "Nzz", opts, "move a half-page up and center the cursor")
vim.keymap.set('c', '<CR>', function() return vim.fn.getcmdtype() == '/' and '<CR>zzzv' or '<CR>' end, { expr = true })

keymap("n", "<leader>L", ":lua require(\"harpoon.ui\").toggle_quick_menu() <CR>", opts, "open harpoon menu")
keymap("n", "<leader>l", ":lua require(\"harpoon.mark\").add_file() <CR>", opts, "add current file to harpoon list")
keymap("n", "<leader>n", ":lua require(\"harpoon.ui\").nav_file(1) <CR>zz", opts, "Navigate to the first pinned file with harpoon")
keymap("n", "<leader>e", ":lua require(\"harpoon.ui\").nav_file(2) <CR>zz", opts, "Navigate to the second pinned file with harpoon")
keymap("n", "<leader>o", ":lua require(\"harpoon.ui\").nav_file(3) <CR>zz", opts, "Navigate to the third pinned file with harpoon")
keymap("n", "<leader>i", ":lua require(\"harpoon.ui\").nav_file(4) <CR>zz", opts, "Navigate to the fourth pinned file with harpoon")
keymap("n", "<leader>x", ":Ex <CR>", opts, "Open File Browser (netrw)")
keymap("n", "<leader>u", ":lua require('undotree').toggle() <CR>", opts, "Open undotree")

keymap("n", "<leader>dd", ":lua require('dapui').toggle() <CR>", opts, "open debugger ui")
keymap("n", "<leader>do", ":DapStepOver <CR>", opts, "debugger step over")
keymap("n", "<leader>di", ":DapStepInto <CR>", opts, "debugger step into")
keymap("n", "<leader>du", ":DapStepOut <CR>", opts, "debugger step out")
keymap("n", "<leader>dt", ":DapToggleBreakpoint <CR>", opts, "debugger toggle breakpoint")
keymap("n", "<leader>dc", ":DapContinue <CR>", opts, "debugger continue")
keymap("n", "<leader>ds", ":DapTerminate <CR> <bar> lua require('dapui').close() <CR>", opts, "debugger stop")

keymap("n", "gs", ":TSJSplit <CR>", opts, "split a block of code, such as arrays or arguments, in multiple lines" )
keymap("n", "gj", ":TSJJoin <CR>", opts, "consolidate a block of code, such as arrays or arguments, into a single line")

keymap("n", "<C-k>", ":m-2 <CR>", opts, "move the current line up")
keymap("n", "<C-j>", ":m+1 <CR>", opts, "move the current line down")
keymap("x", "<C-k>", ":m-2 <CR>gv=gv", opts, "move the visually selected lines up")
keymap("x", "<C-j>", ":m'>+ <CR>gv=gv", opts, "move the visually selected lines down")

keymap("n", "<leader>f", ":Telescope find_files <CR>", opts, "open file search with Telescope")
keymap("n", "<leader>g", ":Telescope live_grep <CR>", opts, "search project with Telescope(ripgrep)")
keymap("n", "<leader>F", ":Telescope git_files <CR>", opts, "search git files")
keymap("n", "<leader>b", ":Telescope git_branches <CR>", opts, "search git branches")
keymap("n", "<leader>B", ":Telescope git_commits <CR>", opts, "search git branches")

keymap("n", "<leader>t", ":Git <CR>", opts, "open fugitive")

keymap("n", "<leader>y", "\"+y", opts, "yank to system clipboard")
keymap("v", "<leader>y", "\"+y", opts, "yank to system clipboard")
keymap("n", "<leader>p", "\"+p", opts, "paste to system clipboard")
keymap("v", "<leader>p", "\"+p", opts, "paste to system clipboard")

keymap("n", "<leader>P", ":lua require'telescope'.extensions.projects.projects{}<CR>", opts, "browse projects")
keymap("n", "<leader>S", ":lua SwitchHeader()", opts, "switch between cpp header and main")

keymap("n", "gb", ":ene<CR>", opts, "open new buffer")
keymap("n", "gn", ":bn<CR>", opts, "go to next buffer")
keymap("n", "gp", ":bp<CR>", opts, "go to previous buffer")

function SwitchHeader()
    local file = vim.api.nvim_buf_get_name(0)
    local lookup = {}
    lookup["cpp"] = "hpp"
    lookup["hpp"] = "cpp"
    lookup["c"] = "h"
    lookup["h"] = "c"
    local type = string.match(file, "%a+$")
    local fileToOpen , _ =string.gsub(file, "%a+$", lookup[type])
    if (lookup[type] ~= nil) then
        vim.cmd(":e "..fileToOpen)
    end
end
