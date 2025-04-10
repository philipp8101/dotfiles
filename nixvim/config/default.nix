{ ... }@args:
{
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./keymaps.nix
    (import ./colorscheme.nix args)
    ./treesitter.nix
    (import ./lsp.nix args)
    ./telescope.nix
    ./lualine.nix
    # ./fugitive.nix
    (import ./harpoon.nix args)
    ./undotree.nix
    (import ./treesj.nix args)
    ./cmp.nix
    ./neo-tree.nix
    ./trouble.nix
    ./which-key.nix
    ./todo-comments.nix
    ./comment.nix
    ./diffview.nix
    ./gitsigns.nix
    ./tpope.nix
    ./dap.nix
    ./markdown-preview.nix
    ./colorizer.nix
    ./indent-blankline.nix
    ./dadbod.nix
    ./conform.nix
    ./navbuddy.nix
    ./surround.nix
    ./neogit.nix
    ./web-devicon.nix
    ./treesitter-textobjects.nix
    ./harpoon2-plugin.nix
  ];
}
