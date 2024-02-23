vim.g.airline_powerline_fonts = 1
vim.cmd([[let g:airline#extensions#tabline#enabled = 1]])

-- colors need to be here too, otherwise indent markers break
vim.cmd.colorscheme("carbonfox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.opt.termguicolors = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvimundo"
vim.g.gitblame_enabled = 0
vim.opt.nrformats:append({ "alpha" })
-- autocmd need because ftplugins reset formatoptions on every filetype
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "*" },
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.foldlevel = 99
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})

vim.diagnostic.config({
	float = { border = _border },
})

-- auto install treesitter for new filetype
local parsers = require("nvim-treesitter.parsers")
function _G.ensure_treesitter_language_installed()
	local lang = parsers.get_buf_lang()
	if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
		vim.schedule_wrap(function()
			vim.cmd("TSInstall " .. lang)
		end)()
	end
end
vim.cmd([[autocmd FileType * :lua ensure_treesitter_language_installed()]])
vim.cmd([[runtime! ftplugin/man.vim]]) -- enable :Man command for manpages
