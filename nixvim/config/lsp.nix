    let enabled_servers = [
      "gopls"
      "clangd"
      "nil_ls"
    ];
    in
{
  plugins.lsp = {
    enable = true;
    servers = builtins.listToAttrs ( builtins.map (s: { name = s ; value = {enable = true;}; }) enabled_servers) // {
      rust-analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };
    keymaps = {
        diagnostic = {
            "gn" = "goto_next";
            "gp" = "goto_prev";
        };
        lspBuf = {
            K = "hover";
            gR = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
            ga = "code_action";
            gr = "rename";
        };
    };
  };

}
