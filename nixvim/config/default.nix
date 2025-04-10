{ ... }@args:
{
  # Import all your configuration modules here
  imports = [
    ./cmp.nix
    ./colorizer.nix
    ./comment.nix
    ./conform.nix
    ./dadbod.nix
    ./dap.nix
    ./diffview.nix
    ./gitsigns.nix
    ./harpoon2-module.nix
    (import ./colorscheme.nix args)
    (import ./harpoon.nix args)
    (import ./lsp.nix args)
    (import ./treesj.nix args)
    ./indent-blankline.nix
    ./keymaps.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./navbuddy.nix
    ./neogit.nix
    ./neo-tree.nix
    ./options.nix
    ./surround.nix
    ./telescope.nix
    ./todo-comments.nix
    ./tpope.nix
    ./treesitter.nix
    ./treesitter-textobjects.nix
    ./trouble.nix
    ./undotree.nix
    ./web-devicon.nix
    ./which-key.nix
  ];
}
