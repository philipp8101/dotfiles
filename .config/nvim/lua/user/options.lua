vim.g.airline_powerline_fonts = 1
vim.cmd([[let g:airline#extensions#tabline#enabled = 1]])
vim.cmd.colorscheme("carbonfox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
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
vim.opt.termguicolors = true
vim.g.gitblame_enabled = 0
vim.opt.nrformats:append({ "alpha" })
-- autocmd need because ftplugins reset formatoptions on every filetype
vim.api.nvim_create_autocmd({"FileType"},{pattern = {"*"}, callback = function ()
    vim.opt.formatoptions:remove({ 'c','r','o' })
end})
