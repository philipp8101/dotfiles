{ pkgs, self, system, user, ... }:
let
  enabled_servers = [
    "gopls"
    "clangd"
    "pyright"
    "texlab"
    "lua_ls"
  ];
in
{
  plugins.lsp = {
    enable = true;
    servers = builtins.listToAttrs (builtins.map (s: { name = s; value = { enable = true; }; }) enabled_servers) // {
      rust_analyzer = {
        enable = true;
        installCargo = true;
        cargoPackage = pkgs.cargo;
        installRustc = true;
        rustcPackage = pkgs.rustc;
      };
      hls = {
        enable = true;
        package = null;
        installGhc = false;
        ghcPackage = null;
      };
      nixd = {
        enable = true;
        settings = {
          formatting.command = [ "nixpkgs-fmt" ];
          nixpkgs.expr = "import <nixpkgs> { }";
          options.nixos.expr = ''(builtins.getFlake "${self}").nixosConfigurations.desktop.options'';
          options."home_manager".expr = ''(builtins.getFlake "${self}").homeConfigurations.philipp.options'';
        };
      };
    };
    keymaps = {
      diagnostic = {
        "]d" = "goto_next";
        "[d" = "goto_prev";
        "gk" = "open_float";
        "gq" = "setloclist";
      };
      lspBuf = {
        K = "hover";
        gR = "references";
        gd = "definition";
        gi = "implementation";
        ga = "code_action";
        gr = "rename";
      };
    };
  };

  # extraPlugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
  # extraPackages = with pkgs; [ arduino-language-server arduino-cli ];
  # extraConfigLua = ''
  #   require("lspconfig").arduino_language_server.setup({
  #     cmd = { "arduino-language-server", "-clangd", "${pkgs.clang-tools_17}/bin/clangd", "-cli", "${pkgs.arduino-cli}/bin/arduino-cli", "-cli-config", "$HOME/.arduino15/arduino-cli.yaml", "-fqbn", "sandeepmistry:nRF5:CalliopeMini" }
  #   })
  # '';
}
