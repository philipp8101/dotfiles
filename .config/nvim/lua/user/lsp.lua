require('lspconfig')['hls'].setup{
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
  cmd = { "haskell-language-server-wrapper", "--lsp" }
}

require('lspconfig')['lua_ls'].setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = {"vim"},
      },
    },
  },
}
