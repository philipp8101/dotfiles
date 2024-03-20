local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts "move a half-page down and center the cursor")
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts "move a half-page up and center the cursor")

vim.keymap.set("n", "n", "nzz", opts "move a half-page up and center the cursor")
vim.keymap.set("n", "N", "Nzz", opts "move a half-page up and center the cursor")
-- center screen atfer search
vim.keymap.set("c", "<CR>", function()
    if vim.fn.getcmdtype() == "/" then
        return "<CR>zz"
    else
        return "<CR>"
    end
end, { expr = true })

vim.keymap.set("n", "<leader>L", require('harpoon.ui').toggle_quick_menu, opts "open harpoon menu")
vim.keymap.set("n", "<leader>l", require('harpoon.mark').add_file, opts "add current file to harpoon list")
vim.keymap.set("n", "<leader>n", '<cmd>lua require("harpoon.ui").nav_file(1) <CR>zz',
    opts "Navigate to the first pinned file with harpoon"
)
vim.keymap.set("n", "<leader>e", '<cmd>lua require("harpoon.ui").nav_file(2) <CR>zz',
    opts "Navigate to the second pinned file with harpoon"
)
vim.keymap.set("n", "<leader>o", '<cmd>lua require("harpoon.ui").nav_file(3) <CR>zz',
    opts "Navigate to the third pinned file with harpoon"
)
vim.keymap.set("n", "<leader>i", '<cmd>lua require("harpoon.ui").nav_file(4) <CR>zz',
    opts "Navigate to the fourth pinned file with harpoon"
)
vim.keymap.set("n", "<leader>x", function()
    if vim.fn.expand('%') == '' then
        vim.cmd(':Neotree')
    else
        vim.cmd(':Neotree %')
    end
end, opts "Open File Browser")
vim.keymap.set("n", "<leader>u", function() require('undotree').toggle() end, opts "Open undotree")

vim.keymap.set("n", "<leader>dd", function() require('dapui').toggle() end, opts "open debugger ui")
vim.keymap.set("n", "<leader>do", "<cmd>DapStepOver <CR>", opts "debugger step over")
vim.keymap.set("n", "<leader>di", "<cmd>DapStepInto <CR>", opts "debugger step into")
vim.keymap.set("n", "<leader>du", "<cmd>DapStepOut <CR>", opts "debugger step out")
vim.keymap.set("n", "<leader>dt", "<cmd>DapToggleBreakpoint <CR>", opts "debugger toggle breakpoint")
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue <CR>", opts "debugger continue")
vim.keymap.set("n", "<leader>ds", "<cmd>DapTerminate <CR> <bar> lua require('dapui').close() <CR>",
    opts "debugger stop")
vim.keymap.set("n", "<leader>de", function() require('dapui').eval() end, opts "debugger stop")

vim.keymap.set("n", "gs", "<cmd>TSJSplit <CR>",
    opts "split a block of code, such as arrays or arguments, in multiple lines")
vim.keymap.set("n", "gj", "<cmd>TSJJoin <CR>",
    opts "consolidate a block of code, such as arrays or arguments, into a single line")

vim.keymap.set("n", "<C-k>", "<cmd>m-2 <CR>", opts "move the current line up")
vim.keymap.set("n", "<C-j>", "<cmd>m+1 <CR>", opts "move the current line down")
vim.keymap.set("x", "<C-k>", "<cmd>m-2 <CR>gv=gv", opts "move the visually selected lines up")
vim.keymap.set("x", "<C-j>", "<cmd>m'>+ <CR>gv=gv", opts "move the visually selected lines down")

vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files hidden=true <CR>",
    opts "open file search with Telescope")
vim.keymap.set("n", "<leader>sF", "<cmd>Telescope find_files hidden=true no_ignore=true <CR>",
    opts "open file search with Telescope")
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep <CR>", opts "search project with Telescope(ripgrep)")
vim.keymap.set("n", "<leader>st", "<cmd>Telescope git_files <CR>", opts "search git files")
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope git_branches <CR>", opts "search git branches")
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope git_commits <CR>", opts "search git branches")
vim.keymap.set("n", "<leader>so", "<cmd>Telescope buffers <CR>", opts "search open buffers")
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags <CR>", opts "search open buffers")

vim.keymap.set("n", "<leader>t", "<cmd>Neogit kind=replace<CR>", opts "open neogit")
vim.keymap.set("n", "<leader>ac", "<cmd>Neogit commit <CR>", opts "commit changes")
vim.keymap.set("n", "<leader>h", "<cmd>Navbuddy <CR>", opts "open Navbuddy")
vim.keymap.set("n", "<leader>H", "<cmd>Trouble <CR>", opts "open Trouble")
vim.keymap.set("n", "<leader>s", "<Plug>(leap-forward-to)", opts "leap forwards")
vim.keymap.set("n", "<leader>S", "<Plug>(leap-backward-to)", opts "leap backwards")

vim.keymap.set("n", "<leader>y", '"+y', opts "yank to system clipboard")
vim.keymap.set("v", "<leader>y", '"+y', opts "yank to system clipboard")
vim.keymap.set("n", "<leader>p", '"+p', opts "paste to system clipboard")
vim.keymap.set("v", "<leader>p", '"+p', opts "paste to system clipboard")

vim.keymap.set("n", "<C-n>", "<cmd>ene<CR>", opts "open new buffer")
vim.keymap.set("n", "gn", "<cmd>bn<CR>", opts "go to next buffer")
vim.keymap.set("n", "gp", "<cmd>bp<CR>", opts "go to previous buffer")
vim.keymap.set("n", "<esc>", "<cmd>noh<CR>", opts "disable highlights")

vim.keymap.set("n", "<C-q>", "<cmd>lclose<CR><cmd>cclose<CR>", opts "close quickfix and location list")
vim.keymap.set("n", "<C-f>", "<cmd>lnext<CR>", opts "next item in location list")
vim.keymap.set("n", "<C-l>", "<cmd>lprev<CR>", opts "previous item in location list")
-- vim.api.nvim_del_keymap("n", "<C-p>")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", opts "next item in quickfix list")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", opts "previous item in quickfix list")
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end, opts "format current file")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts_lsp = function(desc)
            return { noremap = true, silent = true, buffer = ev.buf, desc = desc }
        end
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>zz", opts_lsp "goto declaration")
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts_lsp "goto definition")
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts_lsp "lsp hover")
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>zz", opts_lsp "implementation")
        vim.keymap.set("n", "gr", vim.lsp.buf.rename, opts_lsp "rename")
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references <CR>", opts_lsp "show refrences")
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts_lsp "code actions")
        vim.keymap.set("n", "gk", vim.diagnostic.open_float, opts_lsp "diagnostic hover")
        vim.keymap.set("n", "gq", vim.diagnostic.setloclist, opts_lsp "diagnostics to quickfix list")
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts_lsp "next diagnostic")
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts_lsp "previous diagnostic")
        vim.keymap.set("n", "]D", function()
            require("trouble").next({ skip_groups = true, jump = true })
        end, opts_lsp "next workspace diagnostic")
        vim.keymap.set("n", "[D", function()
            require("trouble").previous({ skip_groups = true, jump = true })
        end, opts_lsp "previous workspace diagnostic")
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = ev.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = ev.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})
