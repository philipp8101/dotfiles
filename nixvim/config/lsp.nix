    let enabled_servers = [
      "gopls"
      "clangd"
      "hls"
      "nil_ls"
      "bashls"
      "cmake"
      "csharp-ls"
      "dockerls"
      "elixirls"
      "elmls"
      "html"
      "htmx"
      "julials"
      "pyright"
      "tsserver"
      "texlab"
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
            "<leader>di" = "open_float";
            "<leader>dq" = "setloclist";
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

  extraPlugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
  extraPackages = with pkgs; [ arduino-language-server arduino-cli ];
  extraConfigLua = ''
    require("lspconfig").arduino_language_server.setup({
      cmd = { "arduino-language-server", "-clangd", "${pkgs.clang-tools_17}/bin/clangd", "-cli", "${pkgs.arduino-cli}/bin/arduino-cli", "-cli-config", "$HOME/.arduino15/arduino-cli.yaml", "-fqbn", "sandeepmistry:nRF5:CalliopeMini" }
    })
  '';
}
