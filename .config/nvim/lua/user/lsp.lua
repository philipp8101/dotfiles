require('lspconfig')['hls'].setup{
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
  cmd = { "haskell-language-server-wrapper", "--lsp" }
}
