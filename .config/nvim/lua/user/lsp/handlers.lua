local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    -- Server capabilities spec:
    -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References",
        })
    end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rD", "<cmd>lua vim.lsp.buf.declaration()<CR>zz", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rK", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ri", "<cmd>lua vim.lsp.buf.implementation()<CR>zz", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rr", ":Telescope lsp_references <CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ra", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ri", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rh", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rl", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
